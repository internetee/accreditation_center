module SendResult
	extend self

	def process(user:, result_params:)

		result = proccess_result_paramas(result_params)

		send_results(user: user, result: result)
	end

	private

	def send_results(user:, result:)
    sender = Results.new
    sender.push_results(user: user, result: result)
  end

	# Example how should result params looks like
	# result_params: [
	# 	{
	# 		category_id: 3,
	# 		result: true
	# 	},
	# 	{
	# 		category_id: 5,
	# 		result: false
	# 	}
	# ]

	def proccess_result_paramas(result_params)
		result_params.each do |param|

		end
		return false
	end

end