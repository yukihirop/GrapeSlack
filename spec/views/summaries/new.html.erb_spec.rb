require 'rails_helper'

RSpec.describe "summaries/new", type: :view do
  before(:each) do
    assign(:summary, Summary.new(
      :title => "MyString",
      :slack => nil
    ))
  end

  it "renders new summary form" do
    render

    assert_select "form[action=?][method=?]", summaries_path, "post" do

      assert_select "input[name=?]", "summary[title]"

      assert_select "input[name=?]", "summary[slack_id]"
    end
  end
end
