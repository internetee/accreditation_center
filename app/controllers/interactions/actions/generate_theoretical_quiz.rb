module GenerateTheoreticalQuiz
  extend self

  def run(user:)
    Quiz.create!(title: "Theory", user: user, theory: true)
  end
end