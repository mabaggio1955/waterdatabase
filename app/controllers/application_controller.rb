class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  ensure_security_headers # See more: https://github.com/twitter/secureheaders
  before_action :set_locale

  helper_method :current_user, :user_signed_in?, :is_admin?

  def current_user
    @current_user ||= ::User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session.delete(:user_id)
    nil
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate!
    user_signed_in? || redirect_to(root_path, notice: "Você precisa estar logado...")
  end

  def default_url_options(options={})
    { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def is_admin?
    ENV['ADMIN_USERS'].split(',').include?(current_user.email)
  end

  def ensure_admin!
    redirect_to(root_path, notice: "Você não tem acesso a essa área") unless is_admin?
  end

end
