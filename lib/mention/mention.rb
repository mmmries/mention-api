module Mention
  class Mention
    include Virtus.value_object(strict: true)

    values do
      attribute :id, Integer
      attribute :title, String
      attribute :description, String
      attribute :url, String
      attribute :published_at, Time
    end
  end
end
