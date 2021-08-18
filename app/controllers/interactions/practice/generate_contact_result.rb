module GenerateContactResult
	extend self

	def process(contact_id:, api_connector:, action:, user: )
		result = nil
		unless contact_id.nil?
      response = api_connector.get_contact(contact_id)

      if response["code"] == 1000
        result = true

        p = Practice.new
        p.user = user
        p.result = result
        p.action_name = action

        p.save!
      else
        result = false
      end
    end

		result
	end
end