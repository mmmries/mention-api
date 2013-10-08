require 'spec_helper_unit'

describe Mention::Account do
  let(:account){ Mention::Account.new(account_id: 'abc', access_token: 'def') }

  it "queries a list of alerts" do
    stub_request(:get, "https://api.mention.net/api/accounts/abc/alerts").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/get_account_alerts.json"))

    account.alerts.size.should == 1
    account.alerts.first.should be_a(Mention::Alert)
  end

  it "queries basic information about the account" do
    stub_request(:get, "https://api.mention.net/api/accounts/abc").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/get_account.json"))

    account.id.should == 'abc'
    account.name.should == "Michael Ries"
    account.email.should == 'michael@riesd.com'
    account.created_at.should == Time.parse("2013-10-06T22:09:48.0+00:00")
  end
end
