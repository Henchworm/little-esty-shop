require 'rails_helper'
RSpec.describe DateService do
  it "gets the api information and parses" do
    expect(DateService.get_date_response).to eq(
      [{:date=>"2022-02-21",
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
     :types=>["Public"]}])
  end
end