require 'rails_helper'
RSpec.describe DateService do
  it "gets the api information and parses" do
    expect(DateService.get_date_response).to eq([{:date=>"2022-02-21", :localName=>"Presidents Day"}])
    end
end