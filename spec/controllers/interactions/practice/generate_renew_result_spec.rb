require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateRenewResult do
	login_user

	

	context "chiecking result conditions" do
		before(:each) do
			@domain_one = "testing.domain"
			@domain_two = "awesome.domain"
	
			@domain_one_expire_date = "2022-12-02T00:00:00.000+03:00"
			@domain_two_expire_date = "2028-03-02T00:00:00.000+03:00"

			def return_response(domain:, expire_date:)
				{
					"code" => 1000,
						"domain" => {
							"name" => "#{domain}",
							"registrant" => "AABB",
							"expire_time"=>"#{expire_date}",
						},
					}
			end

			token = "example-2233"
			@api_connector = GetDomain.new(token)

			@hash = {
				api_connector: @api_connector,
				action: "renew",
				user: @user,
				domain_one: @domain_one,
				domain_two: @domain_two,
				domain_one_expire_date: "2022-09-02T00:00:00.000+03:00",
				domain_two_expire_date: "2022-09-02T00:00:00.000+03:00",
			}

		end

		it "Should return true if renew domain was completed successfully" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_one, is_first_domain: true).and_return(true)
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_two, is_first_domain: false).and_return(true)

			result = GenerateRenewResult.checking_data(@hash)

			expect(result).to be true
		end

		it "should return false if both domains are false" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_one, is_first_domain: true).and_return(false)
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_two, is_first_domain: false).and_return(false)

			result = GenerateRenewResult.checking_data(@hash)

			expect(result).to be false
		end

		it "should return false if first domain is false and second is true" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_one, is_first_domain: true).and_return(false)
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_two, is_first_domain: false).and_return(true)

			result = GenerateRenewResult.checking_data(@hash)

			expect(result).to be false
		end

		it "should return false if first domain is true and second is false" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_one, is_first_domain: true).and_return(true)
			allow(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_two, is_first_domain: false).and_return(false)

			result = GenerateRenewResult.checking_data(@hash)

			expect(result).to be false
		end

		it "should return true for check domain with valid data" do
			allow_any_instance_of(GetDomain).to receive(:get_domain).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))

			allow(GenerateRenewResult).to receive(:compare_data_of_domain).with(
											response: return_response(domain: @domain_one, expire_date: @domain_one_expire_date),
											is_first_domain: true
										).and_return(true)

			result = GenerateRenewResult.send(:check_domain, domain_name: @domain_one, is_first_domain: true)

			expect(result).to be true
		end

		it "should return true for second domain with valid data" do
			allow_any_instance_of(GetDomain).to receive(:get_domain).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))

			allow(GenerateRenewResult).to receive(:compare_data_of_domain).with(
											response: return_response(domain: @domain_one, expire_date: @domain_one_expire_date),
											is_first_domain: true
										).and_return(true)

			result = GenerateRenewResult.send(:check_domain, domain_name: @domain_two, is_first_domain: true)

			expect(result).to be true
		end

		it 'should return true if comparing data are match for first domain' do
			result = GenerateRenewResult.send(:compare_data_of_domain, 
											response: return_response(domain: @domain_one, expire_date: @domain_one_expire_date), is_first_domain: true)

			expect(result).to be true
		end

		it 'should return true if comparing data are match for second domain' do
			result = GenerateRenewResult.send(:compare_data_of_domain, 
											response: return_response(domain: @domain_two, expire_date: @domain_two_expire_date), is_first_domain: false)

			expect(result).to be true
		end

		it 'should return false if comparing data are not match' do
			result = GenerateRenewResult.send(:compare_data_of_domain, 
											response: return_response(domain: @domain_one, expire_date: "2022-09-02T00:00:00.000+03:00"), is_first_domain: true)

			expect(result).to be false
		end

		it "Should update from false to true" do
			allow_any_instance_of(GetDomain).to receive(:get_domain).and_return(return_response(domain: @domain_one, expire_date: "2022-09-02T00:00:00.000+03:00"))

			result = GenerateRenewResult.checking_data(@hash)
			expect(result).to be false

			p = Practice.last
			expect(p.action_name).to eq("renew")
			expect(p.result).to be false

			allow_any_instance_of(GetDomain).to receive(:get_domain).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))
			allow_any_instance_of(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_one, is_first_domain: true).and_return(true)
			allow_any_instance_of(GenerateRenewResult).to receive(:check_domain).with(domain_name: @domain_two, is_first_domain: false).and_return(true)

			result = GenerateRenewResult.checking_data(@hash)

			p = Practice.last
			expect(p.action_name).to eq("renew")
			expect(p.result).to be true
		end
	end
end