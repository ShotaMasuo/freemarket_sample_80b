# require 'rails_helper'

# describe Image do
#   before do
#     @image = build(:image)
#   end
#   describe "create" do

#     it "画像入力されていれば出品できる" do
#       image = FactoryBot.build(:image)
#       binding.pry
#       expect(image).to be_valid
#     end

#     it "商品画像が空では出品できない" do
#       image = FactoryBot.build(:image, image: "")
#       image.valid?
#       expect(image.errors(:image)).to include("can`t be blank")
#     end
#   end
# end