require "spec_helper"

describe GlucoseDataController do
  describe "routing" do

    it "routes to #index" do
      get("/glucose_data").should route_to("glucose_data#index")
    end

    it "routes to #new" do
      get("/glucose_data/new").should route_to("glucose_data#new")
    end

    it "routes to #show" do
      get("/glucose_data/1").should route_to("glucose_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/glucose_data/1/edit").should route_to("glucose_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/glucose_data").should route_to("glucose_data#create")
    end

    it "routes to #update" do
      put("/glucose_data/1").should route_to("glucose_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/glucose_data/1").should route_to("glucose_data#destroy", :id => "1")
    end

  end
end
