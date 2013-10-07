require 'bundler/setup'
require 'mention-api'

require 'support/credentials_context'

RSpec.configure do |c|
  c.color = true
  c.order = :rand
end
