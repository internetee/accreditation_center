class AddAnsweredQuestionsUniqueConstraint < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      ALTER TABLE answered_questions ADD CONSTRAINT 
      one_answer_per_test_question UNIQUE (test_id, question_id, answer_id);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE answered_questions DROP CONSTRAINT one_answer_per_test_question;
    SQL
  end
end
