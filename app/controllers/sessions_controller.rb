class SessionsController < ApplicationController
  def create
    user = User.find_or_create_with_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    if user.persisted?
      session[:user_id] = user.id
      redirect_to categories_path, notice: "Bem-vindo!"
    else
      failure
    end
  end

  def failure
    redirect_to root_path, alert: "Não foi possível autenticar."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
