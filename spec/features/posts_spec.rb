require 'rails_helper'

describe "the signin process", :type => :feature do

  it " link to 单机SDK " do
      visit "/posts"
      expect(page).to have_content("SDK")
  end

end
