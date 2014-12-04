class PagesController < ApplicationController
  def home
    redirect_to contents_path if user_signed_in?
  end

  def dashboard
  end
end
