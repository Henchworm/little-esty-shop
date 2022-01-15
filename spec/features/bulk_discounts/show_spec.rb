require 'rails_helper'
RSpec.describe 'the bulk discounts show page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Nicks Slick Pics')}


  let!(:discount_1) {merchant_1.bulk_discounts.create!(id: 7777, percent_off: 50, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percent_off: 25, quantity_threshold: 20)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percent_off: 15, quantity_threshold: 10)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percent_off: 3, quantity_threshold: 60)}

  it "shows the bulk discount's information" do
    visit "/merchants/bulk_discounts/#{discount_1.id}"
    expect(page).to have_content(discount_1.id)
    expect(page).to have_content(discount_1.percent_off)
    expect(page).to have_content(discount_1.quantity_threshold)
    save_and_open_page
  end
end
