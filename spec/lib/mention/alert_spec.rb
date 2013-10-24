require 'spec_helper_unit'

describe Mention::Alert do
  let(:account){ Mention::Account.new(account_id: 'abc', access_token: 'def') }
  let(:json){ File.read('spec/fixtures/get_account_alerts.json') }
  let(:alert_params){ JSON.parse(json)['alerts'].first }
  let(:alert){ Mention::Alert.new(alert_params) }
  let(:base_url){ "https://api.mention.net/api/accounts/abc/alerts/#{alert.id}/mentions" }

  it "fetches a list of mentions" do
    stub_request(:get, base_url).
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer def'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/mention_list_default.json"))

    mentions = alert.mentions(account)
    mentions.should be_a(Mention::MentionList)
    mentions.count.should == 9
  end

  it "fetches a list of mentions since a given id" do
    stub_request(:get, "#{base_url}?since_id=3199497112").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer def'}).
      to_return(:status => 200, :body => File.read("spec/fixtures/mention_list_since.json"))

    mentions = alert.mentions(account, since_id: "3199497112")
    mentions.should be_a(Mention::MentionList)
    mentions.count.should == 3
  end
end
