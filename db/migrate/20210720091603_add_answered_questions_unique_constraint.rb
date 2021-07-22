class AddAnsweredQuestionsUniqueConstraint < ActiveRecord::Migration[6.1]
   def up
    # execute <<-SQL
    #   ALTER TABLE answer_questions ADD CONSTRAINT 
    #   one_answer_per_test_question UNIQUE (quiz_id, question_id, answer_id);
    # SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE answer_questions DROP CONSTRAINT one_answer_per_test_question;
    SQL
  end
end
