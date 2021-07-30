require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  describe "POST #create" do
    let(:valid_attributes) { FactoryBot.attributes_for(:user) }
		let(:user) { create(:user, id: 1) }

    let(:valid_session) { {} }

    # Help Devise map routes from the test back to the original controller.
    # See http://stackoverflow.com/questions/6659555/how-to-write-controller-tests-when-you-override-devise-registration-controller
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

		login_user

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
