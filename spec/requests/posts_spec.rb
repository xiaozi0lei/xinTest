require 'rails_helper'
require 'spec_helper'
require 'pry'

RSpec.describe "Posts", :type => :request do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      get posts_path
      expect(response.status).to be(200)
    end
    it " link to 单机SDK " do
      visit posts_path
      expect(page).to have_content("SDK")
    end
  end
end
