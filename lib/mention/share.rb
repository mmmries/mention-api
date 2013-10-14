module Mention
  class Share
    include Virtus.model

    attribute :id, String
    attribute :account, Hash

    def account_id
      account['id']
    end
  end
end
