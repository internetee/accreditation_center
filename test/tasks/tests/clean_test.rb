require 'test_helper'
require 'rake'
Rails.application.load_tasks

class CleanExamsTaskTest < ActiveSupport::TestCase
  setup do
    @exam = exams(:one)
    Rails.configuration.exams.days_before_cleaning = 1
  end

  def test_deletes_results_of_old_exams
    travel_to Time.zone.parse('2010-07-05 10:00')
    @exam.update!(end: Time.zone.parse('2010-07-04 09:59'))

    assert_difference -> { @exam.answered_questions.count }, -1 do
      capture_io { run_task }
    end
  end

  def test_keeps_results_of_other_exams_intact
    travel_to Time.zone.parse('2010-07-05 10:00')
    @exam.update!(end: Time.zone.parse('2010-07-04 10:00'))

    assert_no_difference -> { @exam.answered_questions.count } do
      capture_io { run_task }
    end
  end

  def test_output
    travel_to Time.zone.parse('2010-07-05 10:00')
    @exam.update!(end: Time.zone.parse('2010-07-04 09:59'))

    assert_output("Exams processed: 1\n") { run_task }
  end

  private

  def run_task
    Rake::Task['exams:clean'].execute
  end
end
