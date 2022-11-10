module PracticeServices
  class GenerateTransferCodeService
    USERNAME = ENV['ACCR_USERNAME']
    PASSWORD = ENV['ACCR_PASSWORD']

    def call
      domain_creator = CreateDomain.new(username: USERNAME, password: PASSWORD)
      response = domain_creator.create_domain

      if response['code'] == 2202 || response['code'] == 2104 || response['code'] == 2005
        response(success: false, errors: response['message'])
      else
        response(success: true, payload: response.dig('data', 'domain'))
      end
    end

    private

    def response(**kwargs)
      Struct.new(:success?, :payload, :errors)
            .new(kwargs[:success], kwargs[:payload], kwargs[:errors])
    end
  end
end
