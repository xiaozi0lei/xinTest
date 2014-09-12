require 'rails_helper'

RSpec.describe "posts/show", :type => :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :title => "Title",
      :project => "Project",
      :url => "Url",
      :data => "Data",
      :result => "Result"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Project/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Data/)
    expect(rendered).to match(/Result/)
  end
end
