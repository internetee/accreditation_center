require 'rails_helper'
require_relative "../../../support/devise"

RSpec.describe GetDomainExpireDate do
	login_user

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

  it "should return true if data was written into cash" do
    api_connector = instance_double(GetDomain)
    allow(api_connector).to receive(:get_domain).and_return(return_response(domain: @domain_one, expire_date: @domain_one_expire_date))

    result = GetDomainExpireDate.process(domain: @domain_one, api_connector: api_connector)
    expect(result).to be true

    allow(api_connector).to receive(:get_domain).and_return(return_response(domain: @domain_two, expire_date: @domain_two_expire_date))
    result = GetDomainExpireDate.process(domain: @domain_two, api_connector: api_connector)
    expect(result).to be true
  end
end