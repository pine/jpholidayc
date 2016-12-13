require "../spec_helper"

describe JpHoliday::Cache do
  describe "get" do
    it "# nil" do
      cache : MockedCache?

      begin
        cache = MockedCache.new("config")
        cache.get.should eq(nil)
      ensure
        cache.try &.dispose
      end
    end
  end

  describe "set" do
    it "# basic" do
      cache : MockedCache?

      begin
        cache = MockedCache.new("config")
        cache.set({"2016-12-13" => true})
        cache.get.try(&.["2016-12-13"]?).should eq(true)
        cache.get.try(&.["2016-12-14"]?).should eq(nil)
      ensure
        cache.try &.dispose
      end
    end
  end
end
