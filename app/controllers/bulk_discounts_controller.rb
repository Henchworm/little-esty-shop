class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @bulk_discounts = BulkDiscount.where(bulk_discount_params)
  end

  def show
    @bulk_discount = BulkDiscount.find_by(bulk_discount_params)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    bulk_discount = BulkDiscount.new(bulk_discount_params)

    if bulk_discount.valid?
        bulk_discount.save!
        redirect_to merchant_bulk_discounts_path(params[:merchant_id]), notice: "Bulk discount created."
    else
        flash[:alert] = bulk_discount.errors.full_messages.join("") + "!"
        redirect_to  new_merchant_bulk_discount_path(params[:merchant_id])
      end
    end

  def destroy
    BulkDiscount.find_by(bulk_discount_params).delete

    redirect_to merchant_bulk_discounts_path(params[:merchant_id]),  notice: "Bulk discount destroyed."
  end

  private

  def bulk_discount_params
      params.permit(:percent_off, :quantity_threshold, :merchant_id)
  end
end
