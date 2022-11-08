module GenerateAnswer
  extend self

  def process(answer_question_params:, user_answer:, quiz_id:)
    quiz = Quiz.find(quiz_id)
    if answer_question_params[:answer_id].is_a?(Array)
      MultipleAnswerCreate.create_multiple_answer(answer_question_params: answer_question_params,
                                                  user_answer: user_answer)
    else
      SingleAnswerCreate.create_single_answer(answer_question_params: answer_question_params,
                                              user_answer: user_answer)
    end

    p QuestionId.generate_id_for_new_question(question_id: answer_question_params[:question_id],
                                              user_answer: user_answer, quiz: quiz)
  end
end
