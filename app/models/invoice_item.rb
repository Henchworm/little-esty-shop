class InvoiceItem < ApplicationRecord
  belongs_to(:invoice)
  belongs_to(:item)

  enum status: { "pending" => 0, "packaged" => 1, "shipped" => 2 }


  def best_applicable_discount
    item.merchant.bulk_discounts
    .where("bulk_discounts.quantity_threshold <= #{self.quantity}")
    .order(percent_off: :desc)
    .first
  end
end
