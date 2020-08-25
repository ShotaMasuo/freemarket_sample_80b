require 'rails_helper'

describe Item do
  describe '#create' do

    it "商品名、価格、商品説明、カテゴリー、商品状態、配送料の負担、発送元の地域、発送までの日数、が入力されていれば出品できる" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "商品名が空では出品できない" do
      item = FactoryBot.build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品説明が空では出品できない" do
      item = FactoryBot.build(:item, detail: "")
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    it "商品の状態が空では出品できない" do
      item = FactoryBot.build(:item, condition: "")
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "配送料の負担が空では出品できない" do
      item = FactoryBot.build(:item, fee: "")
      item.valid?
      expect(item.errors[:fee]).to include("を入力してください")
    end

    it "配送元の地域が空では出品できない" do
      item = FactoryBot.build(:item, prefecture: "")
      item.valid?
      expect(item.errors[:prefecture]).to include("を入力してください")
    end

    it "発送までの日数が空では出品できない" do
      item = FactoryBot.build(:item, delivery_date: "")
      item.valid?
      expect(item.errors[:delivery_date]).to include("を入力してください")
    end

    it "価格が空では出品できない" do
      item = FactoryBot.build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

  end
end