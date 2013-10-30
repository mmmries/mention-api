require 'spec_helper_unit'

describe Mention::Mention do
  let(:json){ File.read('spec/fixtures/mention_list_default.json') }
  let(:mention_params){ JSON.parse(json)['mentions'].first }
  let(:mention){ Mention::Mention.new(mention_params) }

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
  end
end
