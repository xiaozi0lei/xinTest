require 'rails_helper'

RSpec.describe "posts/index", :type => :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :title => "Title",
        :project => "Project",
        :url => "Url",
        :data => "Data",
        :result => "Result"
      ),
      Post.create!(
        :title => "Title",
        :project => "Project",
        :url => "Url",
        :data => "Data",
        :result => "Result"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Project".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Data".to_s, :count => 2
    assert_select "tr>td", :text => "Result".to_s, :count => 2
  end
end
