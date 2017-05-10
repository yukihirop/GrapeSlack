require 'rails_helper'

RSpec.describe "Slacks", type: :request do
  describe "GET /slacks" do
    it "works! (now write some real specs)" do
      get slacks_path
      expect(response).to have_http_status(200)
    end
  end
end
