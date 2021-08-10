require 'rails_helper'

RSpec.describe "Results", type: :request do
  let(:result) { create(:result) }
  let(:category) { create(:category) }
  describe "GET /show" do
    it "returns http success" do
    #   get :show, params: { id: result.id, category_id: category.id }

    #   p response
    end
  end

end
