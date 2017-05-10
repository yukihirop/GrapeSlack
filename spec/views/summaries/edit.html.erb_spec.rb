require 'rails_helper'

RSpec.describe "summaries/edit", type: :view do
  before(:each) do
    @summary = assign(:summary, Summary.create!(
      :title => "MyString",
      :slack => nil
    ))
  end

  it "renders the edit summary form" do
    render

    assert_select "form[action=?][method=?]", summary_path(@summary), "post" do

      assert_select "input[name=?]", "summary[title]"

      assert_select "input[name=?]", "summary[slack_id]"
    end
  end
end
