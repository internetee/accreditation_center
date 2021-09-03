require 'rails_helper'

RSpec.describe GetInvoice do
  context "mock requests" do
		before(:each) do
			@token = "some-token"
			@header = { 'Authorization' => "Basic #{@token}" }
      @api_connector = GetInvoice.new(@token)

			@response_successful = {"code" => "1000", "invoices" => [
        {
            "cancelled_at" => "2021-09-03T13:53:15.393+03:00",
            "total" => "24.0",
        },]
															}
		end

		it "get info about domain" do
			allow(@api_connector).to receive(:headers).and_return(@header)
			allow(@api_connector).to receive(:invoce_endpoint).and_return("https://something/")
      allow(@api_connector).to receive(:request).with(url: @api_connector.invoce_endpoint, 
																	headers: @api_connector.headers, method: :get, params: nil).and_return(@response_successful)

			response = @api_connector.get_invoice
			expect(response["code"]).to eq("1000")
			expect(response["invoices"][0]["cancelled_at"]).to eq("2021-09-03T13:53:15.393+03:00")
			expect(response["invoices"][0]["total"]).to eq("24.0")
		end

		it "should return header" do
			api_connector = GetInvoice.new(@token)
			expect(api_connector.headers).to eq({"Authorization"=>"Basic some-token"})
		end

		it "should return endpoint" do
			ENV['BASE_URL'] = 'https://api.website'
			ENV['GET_INVOICES'] = '/api/invoice_status/'

			api_connector = GetInvoice.new(@token)
			expect(api_connector.invoce_endpoint).to eq("https://api.website/api/invoice_status/")
		end
	end
end