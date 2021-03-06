# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

WillPaginate::ViewHelpers.pagination_options[:previous_label ]= "前一页"
WillPaginate::ViewHelpers.pagination_options[:next_label ]= "后一页"

# custom logger format with timestamp
class Logger  
  def format_message(level, time, progname, msg)  
    "#{time.to_s(:db)} #{level} -- #{msg}\n"  
  end  
end
