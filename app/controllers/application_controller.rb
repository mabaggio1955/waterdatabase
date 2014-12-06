class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  ensure_security_headers # See more: https://github.com/twitter/secureheaders
  before_action :set_locale
  before_action :check_account_expired

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
    user_signed_in? || redirect_to(root_path, notice: I18n.t("application.authenticate"))
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
    redirect_to(root_path, notice: I18n.t('application.ensure_admin')) unless is_admin?
  end

  def check_account_expired
    if current_user && !is_admin? && current_user.created_at < 30.days.ago
      session[:user_id] = nil
      redirect_to root_path, alert: I18n.t('application.account_expired')
    end
  end
end
