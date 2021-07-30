require 'rails_helper'

def klass
	described_class
end

def new_class_attrs
  {
    username: Faker::Lorem.word,
    password: Faker::Lorem.word
  }
end

def sign_in(params: nil)
	{
			code: 2202,
			message: "Invalid authorization information"
	}
end

def result
	{
			code: 2202,
			message: "Invalid authorization information"
	}
end

def stub_args(options)
  params = options[:request_params]
  result = params.present? ? args.merge(params: params) : args
  result[:url] += options[:add_to_url].to_s
  result.merge!({ headers: options[:headers] }) if options[:headers]
  result
end

RSpec.shared_examples "Request sender" do |options|

  it "Invalid authorization information" do
		expect_any_instance_of(described_class).to receive(sign_in).with(stub_args(options)).and_return(result)
	end
end