require 'rails_helper'

RSpec.describe "contents/new", type: :view do
  before(:each) do
    assign(:content, Content.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :slack_url => "MyString",
      :slack_message => "MyString",
      :summary => nil
    ))
  end

  it "renders new content form" do
    render

    assert_select "form[action=?][method=?]", contents_path, "post" do

      assert_select "input[name=?]", "content[first_name]"

      assert_select "input[name=?]", "content[last_name]"

      assert_select "input[name=?]", "content[slack_url]"

      assert_select "input[name=?]", "content[slack_message]"

      assert_select "input[name=?]", "content[summary_id]"
    end
  end
end
