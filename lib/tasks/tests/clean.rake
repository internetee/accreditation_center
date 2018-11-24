desc 'Delete the results of old tests'

namespace :tests do
  task :clean do
    processed_test_count = 0

    Test.clean_old_tests do |_test|
      processed_test_count += 1
    end

    puts "Tests processed: #{processed_test_count}"
  end
end
