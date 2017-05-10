require 'rails_helper'

RSpec.describe "summaries/index", type: :view do
  before(:each) do
    assign(:summaries, [
      Summary.create!(
        :title => "Title",
        :slack => nil
      ),
      Summary.create!(
        :title => "Title",
        :slack => nil
      )
    ])
  end

  it "renders a list of summaries" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
