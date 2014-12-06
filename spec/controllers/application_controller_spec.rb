require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  describe 'helpers' do
    let(:user) { create(:user) }
    describe 'current_user' do
      context 'logged_in' do
        context 'valid_id' do
          before { session[:user_id] = user.id }

          it { expect(controller.send(:current_user)).to eq(user) }
        end
        context 'invalid_id' do
          before { session[:user_id] = 666 }
          it { expect(controller.send(:current_user)).to be_nil }
          it {
            expect {
              controller.send(:current_user)
            }.to change { session[:user_id] }.from(666).to(nil)
          }
        end
      end
      context ':logged_out' do
        before { session[:user_id] = nil }

        it { expect(controller.send(:current_user)).to be_nil }
      end
    end
    describe 'user_signed_in?' do
      context 'logged_in' do
        before { session[:user_id] = user.id }
        it { expect(controller.send(:user_signed_in?)).to be_truthy }
      end
      context 'logged_out' do
        before { session[:user_id] = nil }
        it { expect(controller.send(:user_signed_in?)).to be_falsey }
      end
    end

    describe 'authenticate!' do
      context 'logged_in' do
        before { session[:user_id] = user.id }

        it { expect(controller.send(:authenticate!)).to be_truthy }
      end
      context 'logged_out' do
        before { session[:user_id] = nil }

        it {
          redirect = double('redirect')
          expect(controller).to receive(:redirect_to).with(root_path, notice: "Você precisa estar logado...").and_return(redirect)
          expect(controller.send(:authenticate!)).to eq(redirect)
        }
      end
    end

    describe "is_admin?" do
      before do
        ENV['ADMIN_USERS'] = 'foo1@bar.com,foo2@bar.com'
      end

      context "admin user" do
        let!(:user) { create(:user, email: 'foo1@bar.com') }

        before do
          expect(controller).to receive(:current_user).and_return(user)
        end

        it { expect(controller.is_admin?).to be true }
      end

      context "normal user" do
        let!(:user) { create(:user, email: 'lorem@bar.com') }

        before do
          expect(controller).to receive(:current_user).and_return(user)
        end

        it { expect(controller.is_admin?).to be false }
      end
    end

    describe "account expiration" do

      context "normal user expired " do
        let!(:user) { create(:user, created_at: 31.days.ago) }

        controller do
          def index
            render text: "ok"
          end
        end

        before do
          login! user
          get :index
        end

        it { is_expected.to redirect_to(root_path) }
        it { expect(controller.current_user).to be nil }
      end

      context "normal not expired user" do
        let!(:user) { create(:user) }

        controller do
          def index
            render text: "ok"
          end
        end

        before do
          login! user
          get :index
        end

        it { expect(response.body).to eq("ok") }
      end

      context "admin user expired" do
        let!(:user) { create(:user, created_at: 31.days.ago) }

        controller do
          def index
            render text: "ok"
          end
        end

        before do
          login_admin! user
          get :index
        end

        it { expect(response.body).to eq("ok") }
      end

      context "admin user not expired" do
        let!(:user) { create(:user) }

        controller do
          def index
            render text: "ok"
          end
        end

        before do
          login_admin! user
          get :index
        end

        it { expect(response.body).to eq("ok") }
      end
    end
  end
end
