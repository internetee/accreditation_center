RSpec.shared_examples "Token generator" do
  let(:username) { Faker::Lorem.word }
  let(:password) { Faker::Internet.password }
  let(:token) { encoded_token(username: username, password: password) }

  it "generates auth token" do
    conn = described_class.new(username: username, password: password)
    expect(conn.auth_token).to eq token
  end

  def encoded_token(username:, password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end
end
