require 'rails_helper'

RSpec.describe "Summaries", type: :request do
  describe "GET /summaries" do
    it "works! (now write some real specs)" do
      get summaries_path
      expect(response).to have_http_status(200)
    end
  end
end
