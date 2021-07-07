module Admin
	class AdminDashboardController < BaseController
		def index
		 @categories = Category.all
		end
	end
end