require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateDeleteResult do
	login_user

	context "chiecking result conditions" do
		before(:each) do

			@domain_one = "testing.domain"

			token = "example-2233"
			@api_connector = double()

			def return_response(domain:, has_status:)
				{
					"code" => 1000,
						"domain" => {
							"name" => "#{domain}",
							"statuses" => ["#{has_status ? "pendingDelete" : ""}"],
						},
					}
			end

			def return_hash(domain) 
				{
					api_connector: @api_connector,
					action: "delete",
					user: @user,
					domain_name: domain
				}
			end
		end


		it "Result should be true if domain has pendingDelete Status" do
			
			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, has_status: true ))

			result = GenerateDeleteResult.checking_data(return_hash(@domain_one))

			expect(result).to be true
		end

		it "Result should be false if domain has not pendingDelete Status" do
			
			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, has_status: false ))

			result = GenerateDeleteResult.checking_data(return_hash(@domain_one))

			expect(result).to be false
		end

		it "Should update from false to true" do

			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, has_status: false ))

			result = GenerateDeleteResult.checking_data(return_hash(@domain_one))
			expect(result).to be false

			p = Practice.last
			expect(p.action_name).to eq("delete")
			expect(p.result).to be false

			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, has_status: true ))

			result = GenerateDeleteResult.checking_data(return_hash(@domain_one))
			expect(result).to be true

			p = Practice.last
			expect(p.action_name).to eq("delete")
			expect(p.result).to be true
		end
	end
end