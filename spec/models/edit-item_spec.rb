require 'rails_helper'

describe Item do
  describe '#update' do

    # name, detail, category, condition, price, fee, prefecture, delivery_dateが存在すれば更新できる
    it "is valid with a name, detail, category, condition, price, fee, prefecture, delivery_date" do
      item = build(:item)
      expect(item).to be_valid
    end

    # nameが空では更新できないこと
    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end
    
    # detailが空では更新できないこと
    it "is invalid without a detail" do
      item = build(:item, detail: nil)
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    # conditionが空では更新できないこと
    it "is invalid without a condition" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end
    
    # priceが空では更新できないこと
    it "is invalid without a price" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    # feeが空では更新できないこと
    it "is invalid without a fee" do
      item = build(:item, fee: nil)
      item.valid?
      expect(item.errors[:fee]).to include("を入力してください")
    end

    # prefectureが空では更新できないこと
    it "is invalid without a prefecture" do
      item = build(:item, prefecture: nil)
      item.valid?
      expect(item.errors[:prefecture]).to include("を入力してください")
    end

    # delivery_dateが空では更新できないこと
    it "is invalid without a delivery_date" do
      item = build(:item, delivery_date: nil)
      item.valid?
      expect(item.errors[:delivery_date]).to include("を入力してください")
    end
  end
end