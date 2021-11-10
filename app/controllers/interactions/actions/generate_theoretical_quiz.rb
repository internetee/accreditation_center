module GenerateTheoreticalQuiz
  extend self

  def run(user:)
    Quiz.create!(title: "Theory", user: user, theory: true) if searching_unfinished_quizzes?(user: user)
  end

  def searching_unfinished_quizzes?(user:)
    user.quizzes.where(theory: true).all? { |q| q.has_result? }
  end
end