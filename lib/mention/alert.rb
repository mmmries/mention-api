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
  end
end
