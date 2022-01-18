require 'rails_helper'
RSpec.describe "the edit page" do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Nicks Slick Pics')}


  let!(:discount_1) {merchant_1.bulk_discounts.create!(id: 7777, percent_off: 50, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percent_off: 25, quantity_threshold: 20)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percent_off: 15, quantity_threshold: 10)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percent_off: 3, quantity_threshold: 60)}


  it "shows a form that can be filled in to update the bulk discount" do
    visit edit_merchant_bulk_discount_path(merchant_1, discount_1)
    expect(page).to have_content("Update Bulk Discount ##{discount_1.id}")
    expect(page).to have_field(:percent_off, placeholder: "50%")
    expect(page).to have_field(:quantity_threshold, placeholder: 10)
  end
end