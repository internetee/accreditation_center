require 'application_system_test_case'

class Admin::ExamsTest < ApplicationSystemTestCase
  setup do
    sign_in administrators(:one)
    @exam = exams(:one)
  end

  def test_general_data
    @exam.update!(start: Time.zone.parse('2010-07-05 08:00'),
                  end: Time.zone.parse('2010-07-05 08:30'))

    visit admin_exam_url(@exam)

    assert_text "Start\n#{l Time.zone.parse('2010-07-05 08:00')}"
    assert_text "End\n#{l Time.zone.parse('2010-07-05 08:30')}"
  end
end
