require "rails_helper"

RSpec.describe CategoriesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categories").to route_to("categories#index")
      expect(:get => "/pt-BR/categories").to route_to("categories#index", :locale => "pt-BR")
      expect(:get => "/categories/1/contents").to route_to("contents#index", :category_id => "1")
    end

  end
end
