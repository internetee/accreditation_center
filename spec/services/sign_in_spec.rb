require 'rails_helper'

RSpec.describe SignIn do
	it_behaves_like "Token generator"

	context 'simple request' do
		options = {
			url: '/get_info',
      method: :get,
			headers: 'Basic some-token'
		}
    it_behaves_like 'Request sender', options
  end
end
