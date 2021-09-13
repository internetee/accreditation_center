module SendResult
	extend self

	def process(user:)
		theory_result = Result.find_by(user: user)
		practice_result = PracticeResult.find_by(user: user)

		return if theory_result.nil?
		return if practice_result.nil?

		if theory_result.result && practice_result.result
			send_results(user.username)
		end
	end

	private

	def send_results(username)
    sender = Results.new(username)
    sender.push_results
  end
end