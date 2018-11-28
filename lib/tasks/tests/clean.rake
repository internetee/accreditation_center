desc 'Delete the results of old exams'

namespace :exams do
  task :clean do
    processed_exam_count = 0

    Exam.clean_old_exams do |_exam|
      processed_exam_count += 1
    end

    puts "Exams processed: #{processed_exam_count}"
  end
end
