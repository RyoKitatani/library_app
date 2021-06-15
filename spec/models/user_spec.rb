require 'rails_helper'

RSpec.describe User, type: :model do
  describe "データの保存" do
    subject { user.valid? }

    let(:user) { build(:user) }

    it "有効なデータの保存" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    context "空白のバリデーション" do
      it "名前が空欄" do
        user.name = ""
        is_expected.to eq false
      end

      it "メールアドレスが空白" do
        user.email = ""
        is_expected.to eq false
      end

      it "パスワードが空白" do
        user.password = ""
        is_expected.to eq false
      end
    end

    context "データの一致" do
      it "パスワードの一致" do
        user.password = "123456"
        user.password_confirmation = "123456"
        is_expected.to eq true
      end

      it "パスワードの不一致" do
        user.password = "123456"
        user.password_confirmation = "123457"
        is_expected.to eq false
      end
    end

    context "名前の文字数のチェック" do
      it "名前の文字数が20文字以内" do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end

      it "名前の文字数が21文字以上" do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'questionモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:rentals).macro).to eq :has_many
      end
    end

    context 'bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
