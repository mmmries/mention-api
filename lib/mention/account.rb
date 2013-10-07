module Mention
  class Account
    def initialize(credentials)
      @account_id = credentials.fetch(:account_id)
      @access_token = credentials.fetch(:access_token)
    end

    def alerts
      @alerts ||= JSON.parse(resource['alerts'].get)
    end

    private
    attr_reader :account_id, :access_token

    def resource
      @resource ||= RestClient::Resource.new("https://api.mention.net/api/accounts/#{account_id}",
        headers: {'Authorization' => "Bearer #{access_token}", "Accept" => "application/json"})
    end
  end
end
