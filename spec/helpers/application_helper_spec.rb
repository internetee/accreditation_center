require "rails_helper"
require_relative "../support/devise"

RSpec.describe ApplicationHelper, :type => :helper do
	let(:user) { build(:user) }

  describe "resources" do
    it "returns resource name" do
      expect(helper.resource_name).to eq(:user)
    end

		it "returns resources" do
			assign(:resource, user)
			expect(helper.resource).to eq(user)
    end

		it "devise mapping" do
			assign(:devise_mapping, Devise.mappings[:user])
			expect(helper.devise_mapping).to be Devise.mappings[:user] 
    end
  end
end