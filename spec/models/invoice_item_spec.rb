require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe "instance methods" do

    let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

    let!(:discount_1) {merchant_1.bulk_discounts.create!(percent_off: 20, quantity_threshold: 10)}
    let!(:discount_2) {merchant_1.bulk_discounts.create!(percent_off: 30, quantity_threshold: 15)}
    let!(:discount_3) {merchant_1.bulk_discounts.create!(percent_off: 20, quantity_threshold: 15)}
    let!(:discount_4) {merchant_1.bulk_discounts.create!(percent_off: 45, quantity_threshold: 20)}
    let!(:discount_5) {merchant_1.bulk_discounts.create!(percent_off: 50, quantity_threshold: 20)}





    let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
    let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
    let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
    let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
    let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)}
    let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)}


    let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}
    let!(:customer_2) {Customer.create!(first_name: 'Dave', last_name: 'King')}
    let!(:customer_3) {Customer.create!(first_name: 'Reid', last_name: 'Anderson')}
    let!(:customer_4) {Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')}
    let!(:customer_5) {Customer.create!(first_name: 'Ethan', last_name: 'Iverson')}
    let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}

    let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}
    let!(:invoice_2) {customer_2.invoices.create!(status: 'completed' )}
    let!(:invoice_3) {customer_3.invoices.create!(status: 'completed' )}
    let!(:invoice_4) {customer_4.invoices.create!(status: 'completed' )}
    let!(:invoice_5) {customer_5.invoices.create!(status: 'completed' )}
    let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}

    let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

    let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
    let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

    let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 10, unit_price: 10, status: 'shipped')}
    let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 15, unit_price: 10, status: 'packaged')}
    let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 20, unit_price: 50, status: 'pending', created_at: Time.new(2021))}


    #sad path: quantitity thesholds not met
    let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 5, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
    let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 3, unit_price: 50, status: 'pending', created_at: Time.new(2020))}

    it "finds the best discount" do
      expect(invoice_item_1.best_applicable_discount).to eq(discount_1)
      expect(invoice_item_2.best_applicable_discount).to eq(discount_2)
      expect(invoice_item_3.best_applicable_discount).to eq(discount_5)
    end

    it "sad path for discounts that cannot be applied" do
      expect(invoice_item_4.best_applicable_discount).to eq(nil)
    end

    it "returns the total discounted revenue for an invoice item" do
      expect(invoice_item_1.items_discounted_revenue).to eq(80)
      expect(invoice_item_2.items_discounted_revenue).to eq(105)
      expect(invoice_item_3.items_discounted_revenue).to eq(500)
    end

    it "returns a total revenue for an invoice item if no discount is applied" do
      #invoice_items #4 and #5 do not meet the quant threshold for any discount
      expect(invoice_item_4.items_discounted_revenue).to eq(250)
      expect(invoice_item_5.items_discounted_revenue).to eq(150)
    end

  end














end
