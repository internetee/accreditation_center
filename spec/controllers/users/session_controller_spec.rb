require 'rails_helper'
require_relative "../../support/devise"

RSpec.describe Users::SessionsController, type: :controller do
	before(:each) do
		hash = {
			"data" => {
				"domain" => {
					"transfer_code": "asddsfsf32",
					"name": "awesome.test"
				}
			}
		}

		allow(GenerateTransferCode).to receive(:process).and_return(hash)
	end

  context "shpuld be sign in with exist user" do
		before(:each) do
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

	context "checking protected methods" do
		login_user

		it 'checking existing username' do
			result = {
				"code" => 1000,
				"data" => {
					"username" => "#{@user.username}"
				}
			}

			@controller = Users::SessionsController.new

			allow(@controller).to receive(:sign_in).with(@user).and_return("Success")

			result = @controller.send(:checking_username, result)
			expect(result).to eq("Success")
		end

		it 'should return new user and new quiz for him' do
			username = "Alyosha"
			result = {
				"code" => 1000,
				"data" => {
					"username" => "#{username}",
					"registrar_email" => "some@email.com"
				}
			}

			@controller = Users::SessionsController.new

			expect(User.all.count).to eq(1)

			allow(@controller).to receive(:sign_in).and_return("Success")
			@controller.send(:checking_username, result)

			expect(User.all.count).to eq(2)

			alyosha = User.find_by(username: username)
			expect(alyosha.quizzes.count).to eq(2)

			# When created user should be created two quizzes - theory quiz and practical quiz
			expect(alyosha.quizzes.where(theory: true).count).to eq(1)
			expect(alyosha.quizzes.where(theory: false).count).to eq(1)
		end
	end
end
