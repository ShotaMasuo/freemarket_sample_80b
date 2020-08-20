require 'rails_helper'
describe CreditCard do
  describe '#create' do
    it "is invalid without a user_id" do
      card = CreditCard.new(user_id: "", customer_id: "111111111111111",card_id: "111111111111111")
      card.valid?
      expect(card.errors[:user]).to include("must exist")
    end
  end

  describe '#create' do
    it "is invalid without a customer_id" do
      card = CreditCard.new(user_id: "1", customer_id: "",card_id: "111111111111111")
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end
  end

  describe '#create' do
    it "is invalid without a user_id" do
      card = CreditCard.new(user_id: "1", customer_id: "111111111111111",card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end
  end
end