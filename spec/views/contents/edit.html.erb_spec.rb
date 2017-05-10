require 'rails_helper'

RSpec.describe "contents/edit", type: :view do
  before(:each) do
    @content = assign(:content, Content.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :slack_url => "MyString",
      :slack_message => "MyString",
      :summary => nil
    ))
  end

  it "renders the edit content form" do
    render

    assert_select "form[action=?][method=?]", content_path(@content), "post" do

      assert_select "input[name=?]", "content[first_name]"

      assert_select "input[name=?]", "content[last_name]"

      assert_select "input[name=?]", "content[slack_url]"

      assert_select "input[name=?]", "content[slack_message]"

      assert_select "input[name=?]", "content[summary_id]"
    end
  end
end
