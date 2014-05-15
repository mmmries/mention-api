require 'spec_helper_unit'

describe Mention::Account do
  let(:account){ Mention::Account.new(account_id: 'abc', access_token: 'def') }

  it "queries a list of alerts" do
    stub_request(:get, "https://api.mention.net/api/accounts/abc/alerts").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/get_account_alerts.json"))

    account.alerts.size.should == 1
    account.alerts.first.should be_a(Mention::Alert)
    account.alerts.first.id.should == '459069'
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

  it "can add alerts to an account" do
    stub_request(:post, "https://api.mention.net/api/accounts/abc/alerts").
      with(:body => "{\"name\":\"ROM\",\"primary_keyword\":\"ROM\",\"included_keywords\":[],\"excluded_keywords\":[],\"required_keywords\":[\"ruby\",\"object\",\"mapper\"],\"noise_detection\":true,\"sentiment_analysis\":false,\"languages\":[\"en\"],\"sources\":[\"web\",\"facebook\",\"twitter\",\"news\",\"blogs\",\"videos\",\"forums\",\"images\"]}",
          :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/post_account_alerts.json"))

    alert = Mention::Alert.new(name: 'ROM', primary_keyword: 'ROM', required_keywords: ['ruby','object','mapper'])
    alert = account.add(alert)
    alert.id.should == '461518'
    alert.name.should == 'ROM'
  end

  it "reports validation errors when creating a new alert" do
    stub_request(:post, "https://api.mention.net/api/accounts/abc/alerts").
      with(:body => "{\"name\":\"ROM\",\"primary_keyword\":\"ROM\",\"included_keywords\":[],\"excluded_keywords\":[],\"required_keywords\":[\"ruby\",\"object\",\"mapper\"],\"noise_detection\":true,\"sentiment_analysis\":false,\"languages\":[],\"sources\":[]}",
          :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/post_account_alerts_failed.json"))

    alert = Mention::Alert.new(name: 'ROM', primary_keyword: 'ROM', required_keywords: ['ruby', 'object', 'mapper'], languages: [], sources: [])
    ->{
      account.add(alert)
    }.should raise_error(Mention::ValidationError, /language/)
  end

  it "removes an alert from the account" do
    stub_request(:get, "https://api.mention.net/api/accounts/abc/alerts").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/get_account_alerts.json"))

    stub_request(:delete, "https://api.mention.net/api/accounts/abc/alerts/459069/shares/209170_64b8a6q53wkks8k0k80c04o8osskc8w0scs8gsk4gco8kg8csw").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer def'}).
      to_return(:status => 200, :body => "true")

    alert = account.alerts.first
    alert.remove_from(account)
  end
end
