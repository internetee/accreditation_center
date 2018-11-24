require 'test_helper'
require 'rake'
Rails.application.load_tasks

class CleanTestsTaskTest < ActiveSupport::TestCase
  setup do
    @test = tests(:one)
    Rails.configuration.tests.days_before_cleaning = 1
  end

  def test_deletes_results_of_old_tests
    travel_to Time.zone.parse('2010-07-05 10:00')
    @test.update!(end: Time.zone.parse('2010-07-04 09:59'))

    assert_difference -> { @test.answered_questions.count }, -1 do
      capture_io { run_task }
    end
  end

  def test_keeps_results_of_other_tests_intact
    travel_to Time.zone.parse('2010-07-05 10:00')
    @test.update!(end: Time.zone.parse('2010-07-04 10:00'))

    assert_no_difference -> { @test.answered_questions.count } do
      capture_io { run_task }
    end
  end

  def test_output
    travel_to Time.zone.parse('2010-07-05 10:00')
    @test.update!(end: Time.zone.parse('2010-07-04 09:59'))

    assert_output("Tests processed: 1\n") { run_task }
  end

  private

  def run_task
    Rake::Task['tests:clean'].execute
  end
end
