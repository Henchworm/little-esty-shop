require 'rails_helper'
RSpec.describe HolidayDate do

  let!(:data) {[{:date=>"2022-02-21",
      :localName=>"Presidents Day",
      :name=>"Washingtons Birthday",
      :countryCode=>"US",
      :fixed=>false,
      :global=>true,
      :counties=>nil,
      :launchYear=>nil,
      :types=>["Public"]},
      {:date=>"2022-04-15",
      :localName=>"Good Friday",
      :name=>"Good Friday",
      :countryCode=>"US",
      :fixed=>false,
      :global=>false,
      :counties=>
       ["US-CT", "US-DE", "US-HI", "US-IN", "US-KY", "US-LA", "US-NC", "US-ND", "US-NJ", "US-TN"],
      :launchYear=>nil,
      :types=>["Public"]},
      {:date=>"2022-04-01",
     :localName=>"April Fools Day",
     :name=>"Fool Day",
     :countryCode=>"US",
     :fixed=>false,
     :global=>true,
     :counties=>nil,
     :launchYear=>nil,
     :types=>["Public"]}]}

  it "takes parsed JSON on initialized and turns it into object" do
    holiday_date_1 = HolidayDate.new(data)
    expect(holiday_date_1.next_date).to eq("Washingtons Birthday, 2022-02-21")
    expect(holiday_date_1.second_next_date).to eq("Good Friday, 2022-04-15")
    expect(holiday_date_1.third_next_date).to eq("Fool Day, 2022-04-01")
  end
end