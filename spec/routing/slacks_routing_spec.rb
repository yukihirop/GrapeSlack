require "rails_helper"

RSpec.describe SlacksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/slacks").to route_to("slacks#index")
    end

    it "routes to #new" do
      expect(:get => "/slacks/new").to route_to("slacks#new")
    end

    it "routes to #show" do
      expect(:get => "/slacks/1").to route_to("slacks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/slacks/1/edit").to route_to("slacks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/slacks").to route_to("slacks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/slacks/1").to route_to("slacks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/slacks/1").to route_to("slacks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/slacks/1").to route_to("slacks#destroy", :id => "1")
    end

  end
end
