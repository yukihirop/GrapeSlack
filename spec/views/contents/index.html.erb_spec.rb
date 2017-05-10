require 'rails_helper'

RSpec.describe "contents/index", type: :view do
  before(:each) do
    assign(:contents, [
      Content.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :slack_url => "Slack Url",
        :slack_message => "Slack Message",
        :summary => nil
      ),
      Content.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :slack_url => "Slack Url",
        :slack_message => "Slack Message",
        :summary => nil
      )
    ])
  end

  it "renders a list of contents" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slack Url".to_s, :count => 2
    assert_select "tr>td", :text => "Slack Message".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
