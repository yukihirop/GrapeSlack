require "rails_helper"

RSpec.describe SummariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/summaries").to route_to("summaries#index")
    end

    it "routes to #new" do
      expect(:get => "/summaries/new").to route_to("summaries#new")
    end

    it "routes to #show" do
      expect(:get => "/summaries/1").to route_to("summaries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/summaries/1/edit").to route_to("summaries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/summaries").to route_to("summaries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/summaries/1").to route_to("summaries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/summaries/1").to route_to("summaries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/summaries/1").to route_to("summaries#destroy", :id => "1")
    end

  end
end
