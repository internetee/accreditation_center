module GeneratePracticeResult
	extend self

  def start_counting(user)
    practice_results = Practice.where(user_id: user).order(:created_at)

    result = check_each_record_for_result(collection)

    save_result(result: result, user: user)
  end

  private

  def check_each_record_for_result(collection)
    if collection.count == 8
      flag = true

      collection.each do |record|
        flag = false unless record.result
      end

      return flag
    else
      return false
    end
  end

  def save_result(result:, user:)
    PracticeResult.create(user: user, result: result)
  end
end
