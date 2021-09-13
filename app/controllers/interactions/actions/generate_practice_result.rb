module GeneratePracticeResult
	extend self

  def start_counting(user)
    collection = Practice.where(user_id: user).order(:created_at)

    result = check_each_record_for_result(collection)

    save_result(result: result, user: user)
    SendResult.process(user: user)
  end

  private

  def check_each_record_for_result(collection)
    flag = true

    collection.each do |record|
      flag = false unless record.result
    end

    return flag
  end

  def save_result(result:, user:)
    PracticeResult.create(user: user, result: result)
  end
end
