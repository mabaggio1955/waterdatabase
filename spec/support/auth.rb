module AuthSpecHelper
  def current_user
    @current_user ||= create(:user)
  end

  def login!
    session[:user_id] = current_user.id
  end
  def login_admin!
    session[:user_id] = current_user.id
    ENV['ADMIN_USERS'] = current_user.email
  end
end

RSpec.configure do |config|
  config.include AuthSpecHelper, type: :controller
end

RSpec.shared_examples_for "authentication_required_action" do
  context 'logged_out' do
    before { action }

    it { is_expected.to redirect_to(root_path) }
    it { is_expected.to set_the_flash.to('Você precisa estar logado...') }
  end
end

RSpec.shared_examples_for "authentication_required_for_admin" do
  context "not signed as admin" do
    before { action }

    it { expect(controller.is_admin?).to be false }
    it { is_expected.to redirect_to(root_path) }
  end
end