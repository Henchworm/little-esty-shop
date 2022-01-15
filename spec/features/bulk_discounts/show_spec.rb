require 'rails_helper'
RSpec.describe 'the bulk discounts show page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Nicks Slick Pics')}


  let!(:discount_1) {merchant_1.bulk_discounts.create!(id: 7777, percent_off: 50, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percent_off: 25, quantity_threshold: 20)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percent_off: 15, quantity_threshold: 10)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percent_off: 3, quantity_threshold: 60)}

  it "shows the bulk discount's information" do
    visit merchant_bulk_discount_path(merchant_1, discount_1)
    expect(page).to have_content(discount_1.id)
    expect(page).to have_content(discount_1.percent_off)
    expect(page).to have_content(discount_1.quantity_threshold)
  end

  it "has link that updates the bulk discount" do
    visit merchant_bulk_discount_path(merchant_1, discount_1)
    click_link "Edit Discount ##{discount_1.id}"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/7777/edit")
    fill_in :percent_off, with: 99
    fill_in :quantity_threshold, with: 999
    click_button "Update Bulk Discount"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/7777")
    expect(page).to have_content("999")
  end

  it "has sad path page refresh and method for failed update" do
    visit merchant_bulk_discount_path(merchant_1, discount_1)
    click_link "Edit Discount ##{discount_1.id}"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/7777/edit")
    fill_in :percent_off, with: 120
    fill_in :quantity_threshold, with: 999
    click_button "Update Bulk Discount"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/7777/edit")
    save_and_open_page
    expect(page).to have_content("Percent off must be less than or equal to 100!")
  end

end
