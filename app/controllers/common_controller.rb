class CommonController < ApplicationController
  def index
    @commons = Common.all
    @common = Common.new
  end
end
