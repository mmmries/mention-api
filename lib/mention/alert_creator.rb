module Mention
  class AlertCreator
    def initialize(account_resource, alert)
      @account_resource, @alert = account_resource, alert
    end

    def created_alert
      @created_alert ||= Mention::Alert.new(response['alert'])
    end

    def valid?
      validate_response!
      true
    end

    private
    attr_reader :account_resource, :alert

    def response
      @response ||= JSON.parse(response_str)
    end

    def response_str
      @response_str ||= account_resource['alerts'].post(
        JSON.generate(request_params),
        :content_type => 'application/json')
    end

    def request_params
      alert.attributes.reject{|k,v| k == :id}
    end

    def validate_response!
      raise ValidationError.new(validation_errors.join(", ")) unless response['alert']
    end

    def validation_errors
      aggregate_errors(response)
    end

    def aggregate_errors(hash_node, list = [])
      if !hash_node.is_a?(Hash)
        []
      elsif hash_node['errors']
        hash_node['errors']
      else
        error_lists = hash_node.map do |key, node|
          aggregate_errors(node)
        end
        error_lists.inject([]) do |list, node_list|
          list + node_list
        end
      end
    end
  end
end
