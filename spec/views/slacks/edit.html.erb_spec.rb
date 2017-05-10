require 'rails_helper'

RSpec.describe "slacks/edit", type: :view do
  before(:each) do
    @slack = assign(:slack, Slack.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :password_digest => "MyString",
      :profile_img_url => "MyString"
    ))
  end

  it "renders the edit slack form" do
    render

    assert_select "form[action=?][method=?]", slack_path(@slack), "post" do

      assert_select "input[name=?]", "slack[first_name]"

      assert_select "input[name=?]", "slack[last_name]"

      assert_select "input[name=?]", "slack[email]"

      assert_select "input[name=?]", "slack[password_digest]"

      assert_select "input[name=?]", "slack[profile_img_url]"
    end
  end
end
