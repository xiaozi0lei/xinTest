class WelcomeController < ApplicationController
  def index
    if params[:locale]
      session[:locale]="zh-CN"
    end
  end
end
