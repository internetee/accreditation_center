require 'rails_helper'
require_relative "../../../support/devise"

module CachingHelpers
  def file_caching_path
    path = "tmp/test#{ENV['TEST_ENV_NUMBER']}/cache"
    FileUtils::mkdir_p(path)

    path
  end
end

RSpec.configure do |config|
  config.include CachingHelpers
end

RSpec.describe GenerateChangeRegistrantEmailResult do
	login_user

	let(:file_cache) { ActiveSupport::Cache.lookup_store(:file_store, file_caching_path) }
	let(:cache) { Rails.cache }

	context "chiecking result conditions" do
		before(:each) do
			allow(Rails).to receive(:cache).and_return(file_cache)

			@domain_one = "testing.domain"
			@domain_two = "awesome.domain"
			@registrant_one_id = "AABB"
			@registrant_two_id = "BBAA"

			token = "example-2233"
			@api_connector = double()

			def return_response(domain:, registrant:)
				{
					"code" => 1000,
						"domain" => {
							"name" => "#{domain}",
							"registrant" => "#{registrant}",
						},
					}
			end

			def return_hash(domain, verified) 
				{
					api_connector: @api_connector,
					action: "change_registrant_email",
					user: @user,
					domain_name: domain,
					verified: verified
				}
			end
		end


		it "Result of compare data should be true if the valid registrant in response" do
			cache.write('priv_contact_id', 'AABB')
			cache.write('org_contact_id', 'BBAA')
			
			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, registrant: @registrant_two_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_one, false))

			expect(result).to be true
		end

		it "Result of compare data should be false if invalid registrant in response" do
			cache.write('priv_contact_id', 'AABB')
			cache.write('org_contact_id', 'BBAA')
			
			allow(@api_connector).to receive(:get_domain).with(@domain_one)
													.and_return(return_response(domain: @domain_one, registrant: @registrant_one_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_one, false))

			expect(result).to be false
		end

		it "Result of compare data should be true if the valid registrant in response and verified true" do
			cache.write('priv_contact_id', 'AABB')
			cache.write('org_contact_id', 'BBAA')
			
			allow(@api_connector).to receive(:get_domain).with(@domain_two)
													.and_return(return_response(domain: @domain_two, registrant: @registrant_one_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_two, true))

			expect(result).to be true
		end

		it "Result of compare data should be false if the invalid registrant in response and verified true" do
			cache.write('priv_contact_id', 'AABB')
			cache.write('org_contact_id', 'BBAA')
			
			allow(@api_connector).to receive(:get_domain).with(@domain_two)
													.and_return(return_response(domain: @domain_two, registrant: @registrant_two_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_two, true))

			expect(result).to be false
		end

		it "Should update from false to true" do
			cache.write('priv_contact_id', 'AABB')
			cache.write('org_contact_id', 'BBAA')

			allow(@api_connector).to receive(:get_domain).with(@domain_two)
													.and_return(return_response(domain: @domain_two, registrant: @registrant_two_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_two, true))
			expect(result).to be false

			p = Practice.last
			expect(p.action_name).to eq("change_registrant_email")
			expect(p.result).to be false

			allow(@api_connector).to receive(:get_domain).with(@domain_two)
			.and_return(return_response(domain: @domain_two, registrant: @registrant_one_id ))

			result = GenerateChangeRegistrantEmailResult.checking_data(return_hash(@domain_two, true))
			expect(result).to be true

			p = Practice.last
			expect(p.action_name).to eq("change_registrant_email")
			expect(p.result).to be true
		end
	end
end