require 'rails_helper'

describe Category do
  describe '#create' do

    it "name入力されていれば出品できる" do
      category = build(:category)
      expect(category).to be_valid
    end

    it "nameでは出品できない" do
      category = FactoryBot.build(:category, name: "")
      category.valid?
      expect(category.errors[:name]).to include("を入力してください")
    end
  end
end