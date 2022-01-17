require 'rails_helper'

RSpec.describe 'the admin invoice show page' do

    let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

    let!(:discount_1) {merchant_1.bulk_discounts.create!(percent_off: 50, quantity_threshold: 3)}

    let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
    let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
    let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'GClassic rock', unit_price: 50)}

    let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}

    let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}

    let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 50, status: 'shipped')}
    let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'pending')}
    let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 3, unit_price: 50, status: 'pending', created_at: Time.new(2021))}


  it 'links from the admin invoices index page' do
    visit 'admin/invoices'
    click_link "#{invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end

  it 'displays invoice attributes' do
    visit "admin/invoices/#{invoice_1.id}"

    expect(page).to have_content("Invoice #{invoice_1.id}")
    expect(page).to have_content(invoice_1.customer_id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d %Y"))
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
  end

  it 'displays Item/InvoiceItem attributes' do

    visit "admin/invoices/#{invoice_1.id}"

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)

    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(invoice_item_2.quantity)
    expect(page).to have_content(invoice_item_3.quantity)

    expect(page).to have_content(invoice_item_1.unit_price)
    expect(page).to have_content(invoice_item_2.unit_price)
    expect(page).to have_content(invoice_item_3.unit_price)
  end



  it 'provides select field to edit the invoice status' do
    invoice_10 = customer_1.invoices.create!(status: 'in progress')

    visit "admin/invoices/#{invoice_10.id}"

    within "#status-select" do
      expect(page).to have_field(:status, with: 'in progress')
      expect(page).to have_button("Update Invoice Status")
      select 'completed', from: :status
      click_on 'Update Invoice Status'
    end

    expect(current_path).to eq("/admin/invoices/#{invoice_10.id}")
    expect(invoice_10.status).to eq('in progress')
  end

  it 'displays total revenue for this invoice' do
    visit "admin/invoices/#{invoice_1.id}"
      expect(page).to have_content('Total Revenue: 300')
  end


  it 'displays total revenue for incorporated discounts' do
    visit "admin/invoices/#{invoice_1.id}"
    expect(page).to have_content("Total Revenue Including Discounts: 225")
  end

  it "displays a link if discount was applied to items" do
    visit "admin/invoices/#{invoice_1.id}"
    click_link "Discount #{discount_1.id}"
    expect(current_path).to eq(merchant_bulk_discount_path(merchant_1.id, discount_1.id))
  end

  it "displays a message if no discounts were applied to the items" do
    visit "admin/invoices/#{invoice_1.id}"
    expect(page).to have_content("No bulks discount applied to this invoice item.", count: 2)
  end
end
