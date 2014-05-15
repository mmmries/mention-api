require 'spec_helper_unit'

describe Mention::Mention do
  let(:account){ Mention::Account.new(account_id: 'abc', access_token: 'def') }
  let(:json){ File.read('spec/fixtures/mention_list_default.json') }
  let(:mention_params){ JSON.parse(json)['mentions'].first }
  let(:mention){ Mention::Mention.new(mention_params) }
  let(:alert_json){ File.read('spec/fixtures/get_account_alerts.json') }
  let(:alert_params){ JSON.parse(alert_json)['alerts'].first }
  let(:alert){ Mention::Alert.new(alert_params) }

  it "has some basic information" do
    mention.id.should == 3253260762
    mention.title.should start_with('SPRUG')
    mention.description.should start_with('Got even more excited about')
    mention.url.should == "https://plus.google.com/communities/117927540789820622012"
    mention.published_at.to_i.should == Time.parse('2013-10-18 21:57:08Z').to_i
    mention.source_type.should == "web"
    mention.source_name.should == "google.com"
    mention.source_url.should == "https://plus.google.com"
    mention.language_code == "en"
    mention.trashed == false
  end

  describe '#update_attr' do
    it 'updates some attribute' do
      stub_request(:put, "https://api.mention.net/api/accounts/abc/alerts/459069/mentions/3253260762").
        with(:body => "{\"trashed\":true}",
             :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer def'}).
             to_return(:status => 200, :body => File.read("spec/fixtures/mention_update_attr.json"))

      new_mention = mention.update_attr(account, alert, trashed: true)
      new_mention.trashed.should == true
      a_request(:put, 'https://api.mention.net/api/accounts/abc/alerts/459069/mentions/3253260762').
        with(body: "{\"trashed\":true}").should have_been_made.once
    end
  end
end
