require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "データの保存" do
    subject { book.valid? }

    let(:category) { create(:category)}
    let!(:book) { build(:book, category_id: category.id) }

    it "有効なデータの保存" do
      expect(FactoryBot.build(:book)).to be_valid
    end

    context "空白のバリデーション" do
      it "タイトルが空欄で通らない" do
        book.title = ""
        is_expected.to eq false
      end

      it "著者が空欄で通る" do
        book.author = ""
        is_expected.to eq true
      end

      it "出版者が空欄で通る" do
        book.publisher = ""
        is_expected.to eq true
      end

      it "ページ数が空欄で通る" do
        book.volume = ""
        is_expected.to eq true
      end

      it "冊数が空欄" do
        book.stock_num = ""
        is_expected.to eq false
      end
    end

    context "文字数のチェック" do
      it "タイトルの文字数が99文字以下は通る" do
        book.title = Faker::Lorem.characters(number: 99)
        is_expected.to eq true
      end

      it "タイトルの文字数が100文字は通る" do
        book.title = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end

      it "タイトルの文字数が101文字以上は通らない" do
        book.title = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end

      it "著者の文字数が39文字以下は通る" do
        book.author = Faker::Lorem.characters(number: 39)
        is_expected.to eq true
      end

      it "著者の文字数が40文字は通る" do
        book.author= Faker::Lorem.characters(number: 40)
        is_expected.to eq true
      end

      it "著者の文字数が41文字以上は通らない" do
        book.author= Faker::Lorem.characters(number: 41)
        is_expected.to eq false
      end

      it "タイトルの文字数が39文字以下は通る" do
        book.publisher = Faker::Lorem.characters(number: 39)
        is_expected.to eq true
      end

      it "出版者の文字数が40文字は通る" do
        book.publisher = Faker::Lorem.characters(number: 40)
        is_expected.to eq true
      end

      it "出版者の文字数が41文字以上は通らない" do
        book.publisher = Faker::Lorem.characters(number: 41)
        is_expected.to eq false
      end

      it "ページ数の文字数が1桁は通る" do
        book.volume= Faker::Number.number(digits: 1)
        is_expected.to eq true
      end

      it "出版者の文字数が3桁は通る" do
        book.volume = Faker::Number.number(digits: 2)
        is_expected.to eq true
      end

      it "出版者の文字数が4桁以上は通らない" do
        book.volume = Faker::Number.number(digits: 4)
        is_expected.to eq false
      end

      it "冊数の文字数が1桁は通る" do
        book.stock_num = Faker::Number.number(digits: 1)
        is_expected.to eq true
      end

      it "冊数の文字数が2桁以上は通らない" do
        book.stock_num = Faker::Number.number(digits: 2)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Book.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end

    context 'rentalモデルとの関係' do
      it '1:Nとなっている' do
        expect(Book.reflect_on_association(:rentals).macro).to eq :has_many
      end
    end

    context 'bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(Book.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
  end
end
