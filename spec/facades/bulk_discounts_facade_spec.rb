require 'rails_helper'
RSpec.describe BulkDiscountsFacade do
  it "finds a merchant by ID" do
    merchant_1 = Merchant.create!(name: 'Billys Pet Rocks')
    expect(BulkDiscountsFacade.merchant(merchant_1.id)).to eq(merchant_1)
  end

  it "returns the holiday info" do
    expect(BulkDiscountsFacade.holiday_info).to be_a(HolidayDate)
  end
end