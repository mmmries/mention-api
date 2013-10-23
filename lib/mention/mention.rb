module Mention
  class Mention
    include Virtus.value_object(strict: true)

    values do
      attribute :id, Integer
    end
  end
end
