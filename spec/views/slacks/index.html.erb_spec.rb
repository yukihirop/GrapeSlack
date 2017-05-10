require 'rails_helper'

RSpec.describe "slacks/index", type: :view do
  before(:each) do
    assign(:slacks, [
      Slack.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :password_digest => "Password Digest",
        :profile_img_url => "Profile Img Url"
      ),
      Slack.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :password_digest => "Password Digest",
        :profile_img_url => "Profile Img Url"
      )
    ])
  end

  it "renders a list of slacks" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Profile Img Url".to_s, :count => 2
  end
end
