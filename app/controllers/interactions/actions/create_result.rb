module CreateResult
	extend self

  def save(result:, user:, action_name:,)
    p = Practice.find_by(user: user, action_name: action_name)

    if p.nil?
      p = Practice.new
      p.user = user
      p.result = result
      p.action_name = action_name

      return p.save!
    end

    return if p.result

    p.update(result: result)
  end

end