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

  def items_discounted_revenue
    if best_applicable_discount.nil?
      return unit_price * quantity
    else
      (unit_price * quantity) - ((unit_price * quantity) * best_applicable_discount.percent_off.to_f / 100)
    end
  end

  def find_discount_id
    if best_applicable_discount.nil?
      return 'No bulks discount applied to this invoice item.'
    else
      best_applicable_discount.id
    end
  end
end
