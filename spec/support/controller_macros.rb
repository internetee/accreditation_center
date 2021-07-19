module ControllerMacros
	def login_admin
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:superadmin]
			sign_in FactoryBot.create(:superadmin)
		end
	end

	def login_user
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			user = FactoryBot.create(:user)
			sign_in user
		end
	end
end