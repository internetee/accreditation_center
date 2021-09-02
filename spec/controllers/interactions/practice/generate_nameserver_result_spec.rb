require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GenerateNameserverResult do
	login_user

	context "chiecking domains" do
		before(:each) do
			@response = {
				"code" => 1000,
				"domain" => {
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

			token = "example-2233"
			@api_connector = GetDomain.new(token)

			@hash = {
				domain_one: "some.test",
				domain_two: "some2.test",
				random_nameserver_one: "ns1.some.test",
				random_nameserver_two: "ns2.another.test",
				random_nameserver: "another.test",
				api_connector: @api_connector,
				action: "domain",
				user: @user
			}
		end

		it "should return true if both domains are true" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api")
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some.test", is_first_domain: true).and_return(true)
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some2.test", is_first_domain: false).and_return(true)

			result = GenerateNameserverResult.checking_data(@hash)
			
			expect(result).to be true
		end

		it "should return false if both domains are false" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api")
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some.test", is_first_domain: true).and_return(false)
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some2.test", is_first_domain: false).and_return(false)

			result = GenerateNameserverResult.checking_data(@hash)
			
			expect(result).to be false
		end

		it "should return false if first domain is false and second is true" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api")
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some.test", is_first_domain: true).and_return(false)
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some2.test", is_first_domain: false).and_return(true)

			result = GenerateNameserverResult.checking_data(@hash)
			
			expect(result).to be false
		end

		it "should return false if first domain is true and second is false" do
			allow(@api_connector).to receive(:request).and_return(@response)
			allow(@api_connector).to receive(:domain_endpoint).and_return("http://example.api")
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some.test", is_first_domain: true).and_return(true)
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some2.test", is_first_domain: false).and_return(false)

			result = GenerateNameserverResult.checking_data(@hash)
			
			expect(result).to be false
		end
	end

context "check contacts" do
		before(:each) do
			@response = {
				"code" => 1000,
				"domain" => {
					"name" => "some.test",
					"registrant" => "AABB",
					"contacts" => [
													{"code"=>"AABB", "type"=>"AdminDomainContact"},
													{"code"=>"AABB", "type"=>"TechDomainContact"}
												],
					"nameservers" => [
														{
															"hostname"=>"ns1.some.test", 
															"ipv4"=>["0.0.0.1"],
															"ipv6"=>[]
														},
														{
															"hostname"=>"ns2.another.test", 
															"ipv4"=>[],
															"ipv6"=>["2001:DB8::1"]
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

			@hash = {
				domain_one: "some.test",
				domain_two: "some2.test",
				random_nameserver_one: "ns1.some.test",
				random_nameserver_two: "ns2.another.test",
				random_nameserver: "another.test",
				api_connector: @api_connector,
				action: "domain",
				user: @user
			}
		end

		it "should return true if for first domain all results true" do
			api_connector = double()
			allow(api_connector).to receive(:get_domain).with("some.test").and_return(@response)

			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some.test", is_first_domain: true).and_return(true)
			allow(GenerateNameserverResult).to receive(:check_namespace).with(domain_name: "some2.test", is_first_domain: false).and_return(true)

			result = GenerateNameserverResult.send(:compare_data_of_domain, response: @response, is_first_domain: true)
			expect(result).to be true
		end

		it 'should return true if namespaces are correct' do
			allow_any_instance_of(GetDomain).to receive(:get_domain).and_return(@response)

			result = GenerateNameserverResult.send(:check_namespace, domain_name: "some.test", is_first_domain: true)
			expect(result).to be true
		end
	end
end