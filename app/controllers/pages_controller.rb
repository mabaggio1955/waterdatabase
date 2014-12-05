class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to categories_path if user_signed_in?
    else
      render layout: "landing"
    end
  end
end