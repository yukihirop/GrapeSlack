require 'rails_helper'

RSpec.describe "summaries/show", type: :view do
  before(:each) do
    @summary = assign(:summary, Summary.create!(
      :title => "Title",
      :slack => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
