require 'spec_helper_acceptance'

describe "Managing Alerts" do
  include_context "credentials"

  it "returns a list of alerts" do
    account.alerts.should be_a(Enumerable)
  end
end
