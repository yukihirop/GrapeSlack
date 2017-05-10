require 'rails_helper'

RSpec.describe "slacks/new", type: :view do
  before(:each) do
    assign(:slack, Slack.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :password_digest => "MyString",
      :profile_img_url => "MyString"
    ))
  end

  it "renders new slack form" do
    render

    assert_select "form[action=?][method=?]", slacks_path, "post" do

      assert_select "input[name=?]", "slack[first_name]"

      assert_select "input[name=?]", "slack[last_name]"

      assert_select "input[name=?]", "slack[email]"

      assert_select "input[name=?]", "slack[password_digest]"

      assert_select "input[name=?]", "slack[profile_img_url]"
    end
  end
end
