# require 'rails_helper'

# RSpec.describe Users::RegistrationsController, type: :controller do

#   describe "POST #create" do
#     let(:valid_attributes) { FactoryBot.attributes_for(:user) }

#     let(:valid_session) { {} }

#     # Help Devise map routes from the test back to the original controller.
#     # See http://stackoverflow.com/questions/6659555/how-to-write-controller-tests-when-you-override-devise-registration-controller
#     before :each do
#       request.env['devise.mapping'] = Devise.mappings[:user]
#     end

#     context "with valid params" do
#       it "creates a new User" do
#         expect {
#           post :create, params: valid_attributes
#         }.to change(User, :count).by(1)
#       end      
#     end

#   end

# end
