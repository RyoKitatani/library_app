require 'rails_helper'

RSpec.describe "AfterLogins", type: :system do
  describe 'ログイン後のテスト' do
    let(:user) { create(:user) }
    # let!(:question) { FactoryBot.create(:question, user_id: user.id) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button "ログイン"
    end

    context '表示内容の確認' do
      it 'ログインしました。が表示される' do
        expect(page).to have_content 'ログインしました。'
      end

      it 'URLが正しい' do
        expect(current_path).to eq books_path
      end
    end

    describe 'ログイン後のテスト' do

      context 'ヘッダーの表示内容' do
        it '借りルンですが表示される' do
          expect(page).to have_link "借りルンです", href: books_path
        end

        it '書籍一覧のリンクが表示される' do
          expect(page).to have_link "書籍一覧", href: books_path
        end

        it '貸出状況のリンクが表示される' do
          expect(page).to have_link "貸出状況", href: rentals_path
        end

        it 'ユーザーのリンクが表示される' do
          expect(page).to have_link "ユーザー一覧", href: users_path
        end

        it 'マイページのリンクが表示される' do
          expect(page).to have_link user.name , href: user_path(user)
        end

        it 'カテゴリー一覧のリンクが表示される' do
          expect(page).to have_link "カテゴリー", href: categories_path
        end

        it 'ログアウトのリンクが表示される' do
          expect(page).to have_link "ログアウト", href: destroy_user_session_path
        end
      end
    end
  end
end
