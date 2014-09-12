require 'rails_helper'

RSpec.describe "posts/new", :type => :view do
  before(:each) do
    assign(:post, Post.new(
      :title => "MyString",
      :project => "MyString",
      :url => "MyString",
      :data => "MyString",
      :result => "MyString"
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "input#post_project[name=?]", "post[project]"

      assert_select "input#post_url[name=?]", "post[url]"

      assert_select "input#post_data[name=?]", "post[data]"

      assert_select "input#post_result[name=?]", "post[result]"
    end
  end
end
