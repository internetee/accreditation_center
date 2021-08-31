require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateTransferCodeResult do
	login_user

	

	context "chiecking contacts" do
		before(:each) do
			@domain_name = "testing.domain"

			def return_response(registrar)
				{
					"code" => 1000,
						"domain" => {
							"registrar" => {
								"name" => "#{registrar}"
							},
							"name" => "some.test",
							"registrant" => "AABB",
							"contacts" => [
															{"code"=>"AABB", "type"=>"AdminDomainContact"},
															{"code"=>"AABB", "type"=>"TechDomainContact"}
														],
							"nameservers" => [
																{
																	"hostname"=>"ns1.some.test", 
																	"ipv4"=>["127.0.0.1"],
																	"ipv6"=>["::FFFF:192.0.2.1", "2001:DB8::1"]
																},
																{
																	"hostname"=>"ns2.another.test", 
																	"ipv4"=>[],
																	"ipv6"=>[]
																}
															],
							"dnssec_keys" => [
																{
																	"flags"=>0, 
																	"protocol"=>3, 
																	"alg"=>3, 
																	"public_key"=>"AwEAAddt2AkLfYGKgiEZB5SmIF8EvrjxNMH6HtxWEA4RJ9Ao6LCWheg8"
																}
							]
						},
					}
			end

			token = "example-2233"
			@api_connector = GetDomain.new(token)

			@hash = {
				api_connector: @api_connector,
				action: "transfer",
				user: @user,
				domain_name: @domain_name,
			}

			ENV['ACCR_REGISTRAR_NAME'] = 'ACCREDITATION EIS'
		end

		it "Should return true if transfer domain was completed successfully" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response('AABB2'))

			result = GenerateTransferCodeResult.checking_data(@hash)

			expect(result).to be true
		end

		it "Should return false if transfer domain was failed" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response('ACCREDITATION EIS'))

			result = GenerateTransferCodeResult.checking_data(@hash)

			expect(result).to be false
		end

		it "Should update from false to true" do
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api/?name=")
			allow(@api_connector).to receive(:request).and_return(return_response('ACCREDITATION EIS'))

			result = GenerateTransferCodeResult.checking_data(@hash)
			expect(result).to be false

			p = Practice.last
			expect(p.action_name).to eq("transfer")
			expect(p.result).to be false

			allow(@api_connector).to receive(:request).and_return(return_response('EIS'))
			result = GenerateTransferCodeResult.checking_data(@hash)
			expect(result).to be true

			p = Practice.last
			expect(p.action_name).to eq("transfer")
			expect(p.result).to be true
		end
	end
end