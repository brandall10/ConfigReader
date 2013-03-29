require './config_reader.rb'

describe ConfigReader do

  describe "Test line parse" do
    before(:each) { @blank_config = ConfigReader.new() }

    it "ignores comments" do
      @blank_config.parse("# This is a comment")
      @blank_config.properties.count.should eq(0) 
    end

    it "parses string val" do
      @blank_config.parse("stuff = value")
      @blank_config["stuff"].should eq("value")
    end

    it "parses bool val" do
      @blank_config.parse("blah = false")
      @blank_config["blah"].should eq(false)
    end
  end

  describe "Test file parse" do
    before(:all) { @test_config = ConfigReader.new("config_test.txt") }

    it "consumes properties" do
      @test_config.properties.count.should eq(4)
    end

    it "produces string val" do
      @test_config["dir"].should be_an(String)  
    end

    it "produces boolean val" do
      @test_config["booltrue"].should be_an(TrueClass)
    end
  end
end