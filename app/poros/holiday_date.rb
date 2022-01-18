class HolidayDate
  attr_reader :next_date, :second_next_date, :third_next_date
  def initialize(data = DateService.get_date_response[0..2])
    @next_date = "#{data[0][:name]}, #{data[0][:date]}"
    @second_next_date = "#{data[1][:name]}, #{data[1][:date]}"
    @third_next_date = "#{data[2][:name]}, #{data[2][:date]}"
  end
end