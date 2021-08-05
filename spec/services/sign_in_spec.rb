require 'rails_helper'

RSpec.describe SignIn do
	it_behaves_like "Token generator"

	context 'simple request' do
    it_behaves_like 'Request sender'
  end
end
