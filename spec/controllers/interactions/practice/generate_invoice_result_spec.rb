# require 'rails_helper'
# require_relative "../../../support/devise"

# RSpec.describe GenerateInvoiceResult do
# 	login_user

# 	context "chiecking result conditions" do
# 		before(:each) do

# 			@domain_one = "testing.domain"

# 			token = "example-2233"
# 			@api_connector = double()

# 			def return_response(current_date:, cancelled:)
# 				date = current_date ? Time.now : Time.now - 1.day
# 				{"code" => "1000", "invoices" => [
# 					{
# 							"cancelled_at" => "#{cancelled ? date : ""}",
# 							"total" => "24.0",
# 					},]
# 																}
# 			end

# 			def return_hash
# 				{
# 					api_connector: @api_connector,
# 					action: "invoice",
# 					user: @user
# 				}
# 			end
# 		end


# 		it "Result should be true if today invoice was cancelled" do
			
# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: true, cancelled: true ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)

# 			expect(result).to be true
# 		end

# 		it "Result should be false if today invoice was not cancelled" do
			
# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: true, cancelled: false ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)

# 			expect(result).to be false
# 		end

# 		it "Result should be false if yesteday invoice was cancelled" do
			
# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: false, cancelled: true ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)

# 			expect(result).to be false
# 		end

# 		it "Result should be false if yesteday invoice was not cancelled" do
			
# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: false, cancelled: false ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)

# 			expect(result).to be false
# 		end

# 		it "Should update from false to true" do

# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: true, cancelled: false ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)
# 			expect(result).to be false

# 			p = Practice.last
# 			expect(p.action_name).to eq("invoice")
# 			expect(p.result).to be false

# 			allow(@api_connector).to receive(:get_invoice)
# 													.and_return(return_response(current_date: true, cancelled: true ))

# 			result = GenerateInvoiceResult.checking_data(return_hash)
# 			expect(result).to be true

# 			p = Practice.last
# 			expect(p.action_name).to eq("invoice")
# 			expect(p.result).to be true
# 		end
# 	end
# end