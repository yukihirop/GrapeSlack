require 'rails_helper'

RSpec.describe "slacks/show", type: :view do
  before(:each) do
    @slack = assign(:slack, Slack.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :password_digest => "Password Digest",
      :profile_img_url => "Profile Img Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Profile Img Url/)
  end
end
