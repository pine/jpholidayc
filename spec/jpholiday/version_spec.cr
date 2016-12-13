require "../spec_helper"

describe JpHoliday do
  it "VERSION" do
    JpHoliday::VERSION.should match(/\d+\.\d+\.\d+/)
  end
end
