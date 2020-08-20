require 'rails_helper'

describe Address do
  describe '#create' do

    # first_name, family_name, first_name_kana, family_name_kana, post_code, prefecture_code, city, townが存在すれば登録できる
    it "is valid with a first_name, family_name, first_name_kana, family_name_kana, post_code, prefecture_code, city, town" do
      address = build(:address)
      expect(address).to be_valid
    end

    # first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end

    # family_nameが空では登録できない
    it "is invalid without a family_name" do
      address = build(:address, family_name: nil)
      address.valid?
      expect(address.errors[:family_name]).to include("can't be blank")
    end

    # first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end

    # family_name_kanaが空では登録できない
    it "is invalid without a family_name_kana" do
      address = build(:address, family_name_kana: nil)
      address.valid?
      expect(address.errors[:family_name_kana]).to include("can't be blank")
    end

    # post_codeが空では登録できない
    it "is invalid without a post_code" do
      address = build(:address, post_code: nil)
      address.valid?
      expect(address.errors[:post_code]).to include("can't be blank")
    end

    # prefecture_codeが空では登録できない
    it "is invalid without a prefecture_code" do
      address = build(:address, prefecture_code: nil)
      address.valid?
      expect(address.errors[:prefecture_code]).to include("can't be blank")
    end

    # cityが空では登録できない
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    # townが空では登録できない
    it "is invalid without a town" do
      address = build(:address, town: nil)
      address.valid?
      expect(address.errors[:town]).to include("can't be blank")
    end

    # post_codeが8文字以上であれば登録できる
    it "is invalid with a post_code that more than 8 characters" do
      address = build(:address, post_code:"000-0000")
      expect(address).to be_valid
    end

    # post_codeが7文字以下であれば登録できない
    it "is invalid with a post_code that has less than 7 characters" do
      address = build(:address, post_code: "000-000")
      address.valid?
      expect(address.errors[:post_code]).to include("is too short (minimum is 8 characters)")
    end
  end
end