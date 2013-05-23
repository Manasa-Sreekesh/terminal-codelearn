class ProfilersController < ApplicationController
  include ProfilerHelper	

  def log
	  if params[:time]
	    record_time_and_command("request-delay","TerminalsController",params[:time],params[:command])
	    profile_logger("request-delay","TerminalsController")
	  end 
	  render :json => {success: "true"}
  end
end
