module ProfilerHelper
        # config variable for enabling/disabling log. To disable profile logger, set METHOD_PROFILE_LOGGER_STATUS = false
        METHOD_PROFILE_LOGGER_STATUS = true

        def profile_logger_enabled?
                METHOD_PROFILE_LOGGER_STATUS
        end


        # profile logger. As of now, it will log the records inside script/performance/hande-request-TerminalUser.txt file
        def profile_logger(file_name,class_name)
                puts $terminal_profiler.report
                File.open "#{Rails.root}/script/performance/#{file_name}-#{class_name}.txt", 'a+' do |file|
                        file.puts $terminal_profiler.report.sort_by(:total_time).order(:desc)
                end
        end

        def record_time_and_command(file_name,class_name,time,command)
                File.open "#{Rails.root}/script/performance/#{file_name}-#{class_name}.txt", 'a+' do |file|
                        file.puts "Time taken to make total-request: #{time} for thi command: #{command}"
                end
        end

end
