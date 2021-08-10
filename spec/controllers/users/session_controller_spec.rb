require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do

  context "shpuld be sign in with exist user" do
		before do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			sign_in FactoryBot.create(:user)
		end

		it 'login with existing user should be successful' do
			expect(response).to have_http_status(:ok)
		end

		it 'existing user isnt creat additional record in db' do
			expect {
				User.all.count
			}.to_not change { User.all.count }
		end
  end
end
