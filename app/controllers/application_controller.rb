class ApplicationController < ActionController::Base
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  # 此处为切换中文的方法, 设置I18n的locale为session中带上来的locale值, zh-CN, 对应与根目录下的locale目录下的语言 
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
  
#  def default_url_options(options={})
#    logger.debug "default_url_options is passed options: #{options.inspect}\n"
#    { locale: I18n.locale }
#  end
end
