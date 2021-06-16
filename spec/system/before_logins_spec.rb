require 'rails_helper'

RSpec.describe "BeforeLogins", type: :system do
  describe 'userのテスト' do
    describe 'トップ画面のテスト' do
      before do
        visit root_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq root_path
        end
      end

      context 'ログイン前: ヘッダーの表示内容' do
        it '借りルンですが表示される' do
          expect(page).to have_link "借りルンです", href: root_path
        end

        it '新規登録のリンクが表示される' do
          expect(page).to have_link "新規登録", href: new_user_registration_path
        end

        it 'ログインのリンクが表示される' do
          expect(page).to have_link "ログイン", href: new_user_session_path
        end

        it 'ゲストログインのリンクが表示される' do
          expect(page).to have_link "ゲストログイン", href: homes_guest_sign_in_path
        end

        it '管理者ログインのリンクが表示される' do
          expect(page).to have_link "管理者ログイン", href: homes_admin_sign_in_path
        end
      end
    end

    describe '新規登録のテスト' do
      before do
        visit new_user_registration_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq new_user_registration_path
        end

        it '新規登録と表示される' do
          expect(page).to have_content '新規登録'
        end

        it 'ユーザー名フォームが表示される' do
          expect(page).to have_field 'user[name]'
        end

        it 'メールアドレスフォームが表示される' do
          expect(page).to have_field 'user[email]'
        end

        it 'パスワードフォームが表示される' do
          expect(page).to have_field 'user[password]'
        end

        it 'パスワード確認フォームが表示される' do
          expect(page).to have_field 'user[password_confirmation]'
        end

        it '新規登録ボタンが表示される' do
          expect(page).to have_button '新規登録'
        end
      end

      context '新規登録成功のテスト' do
        before do
          fill_in 'user[name]', with: Faker::Name.name
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
        end

        it '新規登録が成功する' do
          expect { click_button '新規登録' }.to change(User.all, :count).by(1)
        end

        it '新規登録後のリダイレクト先が、書籍一覧画面に遷移する' do
          click_button '新規登録'
          expect(current_path).to eq books_path
        end
      end

      context '新規登録失敗後のテスト' do
        before do
          fill_in 'user[name]', with: ""
          fill_in 'user[email]', with: ""
          fill_in 'user[password]', with: ""
          fill_in 'user[password_confirmation]', with: ''
        end

        it '新規登録後のリダイレクト先が、トップ画面に遷移する' do
          click_button '新規登録'
          expect(current_path).to eq users_path
        end
      end
    end

    describe 'ログインのテスト' do
      let(:user) { create(:user) }

      before do
        visit new_user_session_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq new_user_session_path
        end

        it 'ログインと表示される' do
          expect(page).to have_content 'ログイン'
        end

        it 'メールアドレスのフォームが表示される' do
          expect(page).to have_field 'user[email]'
        end

        it 'パスワードフォームが表示される' do
          expect(page).to have_field 'user[password]'
        end

        it 'ログインを記憶するが表示される' do
          expect(page).to have_content 'ログインを記憶する'
        end

        it 'ログインボタンが表示される' do
          expect(page).to have_button 'ログイン'
        end
      end

      context 'ログイン成功後のテスト' do
        before do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
        end

        it 'ログイン後のリダイレクト先が、トップ画面になっている' do
          click_button 'ログイン'
          expect(current_path).to eq books_path
        end
      end

      context 'ログイン失敗後のテスト' do
        before do
          fill_in 'user[email]', with: ""
          fill_in 'user[password]', with: ""
        end

        it 'ログイン失敗後のリダイレクト先が、ログイン画面である' do
          click_button 'ログイン'
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

end
