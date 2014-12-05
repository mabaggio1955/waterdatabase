class CategoriesController < ApplicationController
  before_filter :authenticate!

  def index
    @categories = Category.all
  end
end
