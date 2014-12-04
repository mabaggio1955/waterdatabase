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
  end
end