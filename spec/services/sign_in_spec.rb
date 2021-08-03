require 'rails_helper'

RSpec.describe SignIn, type: :services do |options|
  it "Invalid authorization information" do
		invalid_username = Faker::Lorem.word
		invalid_password = Faker::Lorem.word

		inavlid_auth = {
			code: 2202,
			message: "Invalid authorization information"
		}

		SignIn.any_instance.stub(:sign_in).and_return(inavlid_auth)

		loginer = SignIn.new(username: invalid_username, password: invalid_password)

		result = loginer.sign_in
		expect(result[:code]).to eq(2202)
		expect(result[:message]).to eq("Invalid authorization information")
	end

	it "Valid authorization information" do
		username = Faker::Lorem.word
		password = Faker::Lorem.word

		valid_auth = {
    "code": 1000,
    "message": "Command completed successfully",
    "data": {
        "id": 2,
        "username": "#{username}",
        "roles": [
            "super"
        ],
        "accreditation_date": "null",
        "accreditation_expire_date": "null",
        "uuid": "bfc5640f-089c-42ec-a3f5-656d5c1d5b9d",
        "registrar_name": "#{Faker::Lorem.word}",
        "registrar_reg_no": "12345"
			}
		}

		SignIn.any_instance.stub(:sign_in).and_return(valid_auth)

		loginer = SignIn.new(username: username, password: password)

		result = loginer.sign_in
		expect(result[:code]).to eq(1000)
		expect(result[:message]).to eq("Command completed successfully")
	end
end
