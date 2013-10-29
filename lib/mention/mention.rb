module Mention
  class Mention
    include Virtus.value_object(strict: true)

    values do
      attribute :id, Integer
      attribute :title, String
      attribute :description, String
      attribute :url, String
      attribute :published_at, Time
      attribute :source_type, String
      attribute :source_name, String
      attribute :source_url, String
      attribute :language_code, String
    end
  end
end
