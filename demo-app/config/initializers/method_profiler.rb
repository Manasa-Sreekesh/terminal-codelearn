require 'method_profiler'
module MethodProfilerForRails
 
  PROFILER_ENABLE = true

  def self.profiler_enabled?
    PROFILER_ENABLE
  end
end
if MethodProfilerForRails::profiler_enabled?
	$terminal_profiler = MethodProfiler.observe(TerminalsController)
end
