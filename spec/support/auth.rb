module AuthSpecHelper
  def current_user
    @current_user ||= create(:user)
  end

  def login!(user = current_user)
    session[:user_id] = user.id
  end

  def login_admin!(user = current_user)
    session[:user_id] = user.id
    ENV['ADMIN_USERS'] = user.email
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
    before { login! }
    before { action }

    it { is_expected.to set_the_flash.to('Você não tem acesso a essa área') }
    it { is_expected.to redirect_to(root_path) }
  end
end
