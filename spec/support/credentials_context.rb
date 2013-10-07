shared_context "credentials" do
  let(:credential_file){ 'spec/fixtures/credentials.yml' }
  let(:credentials){ YAML.load_file(credential_file) }
  let(:account){ Mention::Account.new(credentials) }
end
