require 'rails_helper'

RSpec.describe "contents/show", type: :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :slack_url => "Slack Url",
      :slack_message => "Slack Message",
      :summary => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Slack Url/)
    expect(rendered).to match(/Slack Message/)
    expect(rendered).to match(//)
  end
end
