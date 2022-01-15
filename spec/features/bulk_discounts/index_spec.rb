require 'rails_helper'
RSpec.describe 'the bulk discounts index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Nicks Slick Pics')}


  let!(:discount_1) {merchant_1.bulk_discounts.create!(id: 7777, percent_off: 50, quantity_threshold: 10)}
  let!(:discount_2) {merchant_1.bulk_discounts.create!(percent_off: 25, quantity_threshold: 20)}
  let!(:discount_3) {merchant_1.bulk_discounts.create!(percent_off: 15, quantity_threshold: 10)}
  let!(:discount_4) {merchant_2.bulk_discounts.create!(percent_off: 3, quantity_threshold: 60)}

  it "displays a link that visits each bulk discount show page" do
    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    click_link("View Bulk Discount ##{discount_1.id}")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{discount_1.id}")
  end


  it "displays a link that creates a new bulk discount" do
    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    click_link("Create a New Bulk Discount")

    fill_in :percent_off, with: 65
    fill_in :quantity_threshold, with: 11
    click_button "Create Bulk Discount"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
    expect(page).to have_content(BulkDiscount.all.last.percent_off)
    expect(page).to have_content(BulkDiscount.all.last.quantity_threshold)
    expect(page).to have_content(BulkDiscount.all.last.id)
    expect(page).to have_content("Bulk discount created.")
  end

  it "displays sad path if create a new bulk discount fails" do
    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    click_link("Create a New Bulk Discount")
    fill_in :percent_off, with: 120
    fill_in :quantity_threshold, with: 11
    click_button "Create Bulk Discount"
    expect(page).to have_content("Percent off must be less than or equal to 100!")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
  end

  it "displays a link that deletes a bulk discount" do
    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    click_link("Delete Bulk Discount #{discount_1.id}")
    expect(page).to_not have_content(discount_1.id)
  end
end
