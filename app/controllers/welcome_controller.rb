class WelcomeController < ApplicationController

  
# 点击右上角"中文"按钮，调用此方法设置语言为中文
  def index
    if params[:locale]
      session[:locale]="zh-CN"
    end
  end
end
