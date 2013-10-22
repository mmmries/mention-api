module Mention
  class Alert
    include Virtus.model

    attribute :id, String
    attribute :name, String
    attribute :primary_keyword, String
    attribute :included_keywords, Array[String]
    attribute :excluded_keywords, Array[String]
    attribute :required_keywords, Array[String]
    attribute :noise_detection, Boolean, default: true
    attribute :sentiment_analysis, Boolean, default: false
    attribute :languages, Array[String], default: ['en']
    attribute :sources, Array[String], default: ["web","facebook","twitter","news","blogs","videos","forums","images"]
    attribute :shares, Array[Share], default: []

    def remove_from(account)
      share = share_for(account)
      account.remove_alert(self, share)
    end

    def mentions(account, params = {})
      account.fetch_mentions(self, params)
    end

    private
    def share_for(account)
      found = shares.find{|share| share.account_id}
      raise Error.new("could not find share for account #{account.id}") if found.nil?
      found
    end
  end
end
