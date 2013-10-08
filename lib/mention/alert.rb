module Mention
  class Alert
    include Virtus.model

    attribute :id, String
    attribute :name, String
    attribute :primary_keyword, String
    attribute :included_keywords, Array[String]
    attribute :excluded_keywords, Array[String]
    attribute :required_keywords, Array[String]
  end
end
