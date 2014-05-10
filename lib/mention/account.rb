module Mention
  class Account
    def initialize(credentials)
      @account_id = credentials.fetch(:account_id)
      @access_token = credentials.fetch(:access_token)
    end

    def alerts
      @alerts ||= begin
        raw_data = JSON.parse(resource['alerts'].get)
        raw_data['alerts'].map do |hash|
          Alert.new(hash)
        end
      end
    end

    def name
      account_info['account']['name']
    end

    def id
      account_info['account']['id']
    end

    def email
      account_info['account']['email']
    end

    def created_at
      Time.parse(account_info['account']['created_at'])
    end

    def add(alert)
      creator = AlertCreator.new(resource, alert)
      @alerts = nil if creator.valid?
      creator.created_alert
    end

    def remove_alert(alert, share)
      resource["/alerts/#{alert.id}/shares/#{share.id}"].delete
    end

    def fetch_mentions(alert, params = {})
      raw_data = JSON.parse(resource["/alerts/#{alert.id}/mentions"].get params: params)
      MentionList.new(raw_data)
    end

    def update_mention_attr(alert, mention, attributes = {})
      headers = {'Content-Type' => 'application/json'}
      payload = attributes.to_json
      resource["/alerts/#{alert.id}/mentions/#{mention.id}"].put(payload, headers)
    end

    private
    attr_reader :account_id, :access_token

    def resource
      @resource ||= RestClient::Resource.new("https://api.mention.net/api/accounts/#{account_id}",
        headers: {'Authorization' => "Bearer #{access_token}", "Accept" => "application/json"})
    end

    def account_info
      @account_info ||= JSON.parse(resource.get)
    end
  end
end
