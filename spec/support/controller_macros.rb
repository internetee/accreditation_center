module ControllerMacros
	def login_admin
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			@admin = FactoryBot.create(:user, superadmin_role: true)
			sign_in @admin
		end
	end

	def login_user
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			@user = FactoryBot.create(:user)
			sign_in @user
		end
	end
end