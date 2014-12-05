require "rails_helper"

RSpec.describe ContentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categories/2/contents").to route_to("contents#index", :category_id => "2")
      expect(:get => "/pt-BR/categories/2/contents").to route_to("contents#index", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #new" do
      expect(:get => "/categories/2/contents/new").to route_to("contents#new", :category_id => "2")
      expect(:get => "/pt-BR/categories/2/contents/new").to route_to("contents#new", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #show" do
      expect(:get => "/categories/2/contents/1").to route_to("contents#show", :id => "1", :category_id => "2")
      expect(:get => "/pt-BR/categories/2/contents/1").to route_to("contents#show", :id => "1", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #edit" do
      expect(:get => "/categories/2/contents/1/edit").to route_to("contents#edit", :id => "1", :category_id => "2")
      expect(:get => "/pt-BR/categories/2/contents/1/edit").to route_to("contents#edit", :id => "1", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #create" do
      expect(:post => "/categories/2/contents").to route_to("contents#create", :category_id => "2")
      expect(:post => "/pt-BR/categories/2/contents/").to route_to("contents#create", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #update" do
      expect(:put => "/categories/2/contents/1").to route_to("contents#update", :id => "1", :category_id => "2")
      expect(:put => "/pt-BR/categories/2/contents/1").to route_to("contents#update", :id => "1", :locale => "pt-BR", :category_id => "2")
    end

    it "routes to #destroy" do
      expect(:delete => "/categories/2/contents/1").to route_to("contents#destroy", :id => "1", :category_id => "2")
      expect(:delete => "/pt-BR/categories/2/contents/1").to route_to("contents#destroy", :id => "1", :locale => "pt-BR", :category_id => "2")
    end
  end
end
