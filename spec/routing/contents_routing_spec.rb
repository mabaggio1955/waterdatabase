require "rails_helper"

RSpec.describe ContentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contents").to route_to("contents#index")
      expect(:get => "/pt-BR/contents").to route_to("contents#index", :locale => "pt-BR")
    end

    it "routes to #new" do
      expect(:get => "/contents/new").to route_to("contents#new")
      expect(:get => "/pt-BR/contents/new").to route_to("contents#new", :locale => "pt-BR")
    end

    it "routes to #show" do
      expect(:get => "/contents/1").to route_to("contents#show", :id => "1")
      expect(:get => "/pt-BR/contents/1").to route_to("contents#show", :id => "1", :locale => "pt-BR")
    end

    it "routes to #edit" do
      expect(:get => "/contents/1/edit").to route_to("contents#edit", :id => "1")
      expect(:get => "/pt-BR/contents/1/edit").to route_to("contents#edit", :id => "1", :locale => "pt-BR")
    end

    it "routes to #create" do
      expect(:post => "/contents").to route_to("contents#create")
      expect(:post => "/pt-BR/contents/").to route_to("contents#create", :locale => "pt-BR")
    end

    it "routes to #update" do
      expect(:put => "/contents/1").to route_to("contents#update", :id => "1")
      expect(:put => "/pt-BR/contents/1").to route_to("contents#update", :id => "1", :locale => "pt-BR")
    end

    it "routes to #destroy" do
      expect(:delete => "/contents/1").to route_to("contents#destroy", :id => "1")
      expect(:delete => "/pt-BR/contents/1").to route_to("contents#destroy", :id => "1", :locale => "pt-BR")
    end
  end
end
