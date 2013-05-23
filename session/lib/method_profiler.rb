require 'method_profiler'

$profilers = []
module MethodProfilerForCode
	
	# config variable for enabling/disabling log. To disable profile logger, set METHOD_PROFILE_LOGGER_STATUS = false
	METHOD_PROFILE_LOGGER_STATUS = true

	def self.profile_logger_enabled?
		METHOD_PROFILE_LOGGER_STATUS
	end

	def self.start_profile(classes)
		classes.each do |f|
			$profilers << MethodProfiler.observe(f)
		end
	end

	# profile logger. As of now, it will log the records inside performance/hande-request.txt file
	def self.profile_logger(file_name,request_url,command)
		yield
		$profilers.each do |f|
			puts f.report
			record_url_and_command(file_name,request_url,command)
			File.open "../performance/#{file_name}.txt", 'a+' do |file|
				file.puts f.report.sort_by(:total_time).order(:desc)
			end
		end
	end	

	# Method for recording the command and url
	def self.record_url_and_command(file_name,request_url,command)
		File.open "../performance/#{file_name}.txt", 'a+' do |file|
			file.puts "Request_url: #{request_url} command_executed: #{command}"
		end
	end
	

end
