require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe "データの保存" do
    subject { bookmark.valid? }

    let(:user) { create(:user) }
    let(:category) { create(:category)}
    let!(:book) { build(:book, category_id: category.id) }
    let!(:bookmark) { build(:bookmark, user_id: user.id, book_id: book.id) }

    context "空白のバリデーション" do
      it "user_idがない場合" do
        bookmark.user_id = " "
        is_expected.to eq false
      end

      it "book_idがない場合" do
        bookmark.book_id = " "
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'bookモデルとの関係' do
      it 'N:1となっている' do
        expect(Bookmark.reflect_on_association(:book).macro).to eq :belongs_to
      end
    end
  end
end