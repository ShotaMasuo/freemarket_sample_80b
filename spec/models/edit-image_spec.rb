require 'rails_helper'

describe Image do
  describe "#update" do

    it "is valid with a image" do
      image = build(:image)
      expect(image).to be_valid
    end

    it "is invalid without a image" do
      image = build(:image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end

  end
end