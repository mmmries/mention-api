require 'spec_helper_acceptance'

describe "Managing Alerts", :acceptance => true do
  include_context "credentials"

  it "returns a list of alerts" do
    account.alerts.should be_a(Enumerable)
  end

  it "creates and deletes an alert" do
    alert = Mention::Alert.new(name: 'mention-api', primary_keyword: 'mention-api', required_keywords: ['ruby','gem'])
    alert = account.add(alert)
    alert.remove_from(account)
  end
end
