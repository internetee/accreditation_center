module GenerateTransferCode
	extend self

	def process
    username = ENV['ACCR_USERNAME']
    password = ENV['ACCR_PASSWORD']

    domain_creator = CreateDomain.new(username: "accr_bot", password: "123456")
    domain_creator.create_domain
  end
end