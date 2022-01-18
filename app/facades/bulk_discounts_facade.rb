class BulkDiscountsFacade
  
  def self.merchant(id)
    Merchant.find(id)
  end

  def self.holiday_info
    json = DateService.get_date_response
    HolidayDate.new(json)
  end
end