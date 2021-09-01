module GetDomainExpireDate
	extend self

	def process(domain: , api_connector:)
    response = api_connector.get_domain(domain.downcase)
    expire_time = response["domain"]["expire_time"]

    Rails.cache.write("domain_#{domain}_expire_date", expire_time) unless Rails.cache.exist?("domain_#{domain}_expire_date")
	end
end
