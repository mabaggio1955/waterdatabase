require "rails_helper"

RSpec.describe DocumentsController, :type => :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/categories/2/contents/1/documents").to route_to("documents#create", content_id: "1", :category_id => "2")
    end

    it "routes to #destroy" do
      expect(:delete => "/categories/3/contents/1/documents/2").to route_to("documents#destroy", content_id: "1", id: "2", :category_id => "3")
    end

  end
end
