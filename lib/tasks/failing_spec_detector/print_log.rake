# frozen_string_literal: true

namespace :failing_specs_detector do
  desc 'Print all logs in console'
  task :print_log do
    puts "Failing specs detector:\n"
    log_file_paths = Dir['failing_specs_detector_log_*.txt']
    log_file_paths.each do |file_path|
      file = File.open(file_path, 'r')
      file_data = file.read
      puts file_data
      File.delete(file_path)
    end
  end
end
