require 'rails_helper'

RSpec.describe Result do
	it_behaves_like "Token generator"

	context 'simple request' do
		options = {
			url: '/push_results',
      method: :post,
			headers: 'Basic some-token'
		}
    it_behaves_like 'Request sender', options
  end
end
