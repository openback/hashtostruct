require File.dirname(__FILE__) + '/spec_helper.rb'

describe Hashtostruct do
  before(:each) do
    @obj = {
      "string" => "text nonsense",
      "int" => "45", 
      "negative_int" => "-45", 
      "float" => "45.4",
      "exp"   => "123.45e1", 
      "null"  => "null",
      "nil"   => "nil",
      "capital_exp" => "123.45E1", 
      "negative_exp" => "-123.45e-1",
      "capital_negative_exp" => "-123.45E-1", 
      "true"   => "true",
      "false"  => "false", 
      "date1"  => "2008-10-26 12:49:45",
      "date2"  => "2008-10-26",
      "date3"  => "2008-10", 
      "time1"  => "12:49:45", 
      "time2"  => "12:49:45Z", 
      "time3"  => "12:49", 
      "time4"  => "12:49:45.55", 
      "time5"  => "12:49:45+03:00", 
      "time6"  => "12:49:45+0300", 
      "time7"  => "12:49:45+03",
      "time8"  => "12:49:45-03:00", 
      "time9"  => "12:49:45-0300", 
      "time10" => "12:49:45-03",
      "array"  => [ "item_1", "45.2", "123e1" ],
      "nested" => {
        "int"    => "32", 
        "string" => "textie"
      }
    }.to_struct
  end
  
  it "should add #to_struct to Hash" do
    Hash.new.should respond_to('to_struct')
  end
  
  it "should create an object with specified properties" do
    @obj.should respond_to('string')
    @obj.should respond_to('float')
  end
  
  it "should set the value as a string" do
    @obj.string.should eql('text nonsense')
  end

  it "should set the value as an integer" do
    @obj.int.should eql(45)
    @obj.negative_int.should eql(-45)
  end

  it "should set the value as float" do
    @obj.float.should eql(45.4)
  end

  it "should set allow exponential values" do
    @obj.exp.should eql(1234.5)
    @obj.negative_exp.should eql(-12.345)
  end

  it "should set allow exponential values with capitals" do
    @obj.capital_exp.should eql(1234.5)
    @obj.capital_negative_exp.should eql(-12.345)
  end

  it "should parse 'yyyy-mm-dd' as Date" do
    @obj.date2.should be_an_instance_of(DateTime)
    @obj.date2.year.should  eql(2008)
    @obj.date2.month.should eql(10)
    @obj.date2.day.should eql(26)
  end
  
  it "should parse 'yyyy-mm' as Date" do
    pending("should it default to the 1st of the month?") do
      @obj.date3.should be_an_instance_of(DateTime)
      @obj.date3.year.should  eql(2008)
      @obj.date3.month.should eql(10)
    end
  end

  it "should parse 'hh:mm:ss' as Time" do
    @obj.time1.should be_an_instance_of(DateTime)
    @obj.time1.hour.should  eql(12)
    @obj.time1.min.should   eql(49)
    @obj.time1.sec.should   eql(45)
  end

  it "should parse 'hh:mm:ssZ' as Time" do
    @obj.time2.should be_an_instance_of(DateTime)
    @obj.time2.hour.should  eql(12)
    @obj.time2.min.should   eql(49)
    @obj.time2.sec.should   eql(45)
    @obj.time2.zone.should eql('+00:00')
  end

  it "should parse 'hh:mm' as Time" do
    @obj.time3.should be_an_instance_of(DateTime)
    @obj.time3.hour.should  eql(12)
    @obj.time3.min.should   eql(49)
  end

  it "should parse 'hh:mm:ss.ss' as Time" do
    @obj.time4.should be_an_instance_of(DateTime)
    @obj.time4.hour.should  eql(12)
    @obj.time4.min.should   eql(49)
    @obj.time4.sec.should   eql(45)
    pending("check fractional part of the second")do
      @obj.time4.sec_fraction.to_f.should eql(0.55)
    end
  end

  it "should parse 'hh:mm:ss+hh:mm' as Time" do
    @obj.time5.should be_an_instance_of(DateTime)
    @obj.time5.hour.should  eql(12)
    @obj.time5.min.should   eql(49)
    @obj.time5.sec.should   eql(45)
    @obj.time5.zone.should eql('+03:00')
  end

  it "should parse 'hh:mm:ss+hhmm' as Time" do
    @obj.time6.should be_an_instance_of(DateTime)
    @obj.time6.hour.should  eql(12)
    @obj.time6.min.should   eql(49)
    @obj.time6.sec.should   eql(45)
    @obj.time6.zone.should eql('+03:00')
  end

  it "should parse 'hh:mm:ss+hh' as Time" do
    @obj.time7.should be_an_instance_of(DateTime)
    @obj.time7.hour.should  eql(12)
    @obj.time7.min.should   eql(49)
    @obj.time7.sec.should   eql(45)
    @obj.time7.zone.should eql('+03:00')
  end

  it "should parse 'hh:mm:ss-hh:mm' as Time" do
    @obj.time8.should be_an_instance_of(DateTime)
    @obj.time8.hour.should  eql(12)
    @obj.time8.min.should   eql(49)
    @obj.time8.sec.should   eql(45)
    @obj.time8.zone.should eql('-03:00')
  end

  it "should parse 'hh:mm:ss-hhmm' as Time" do
    @obj.time9.should be_an_instance_of(DateTime)
    @obj.time9.hour.should  eql(12)
    @obj.time9.min.should   eql(49)
    @obj.time9.sec.should   eql(45)
    @obj.time9.zone.should eql('-03:00')
  end

  it "should parse 'hh:mm:ss-hh' as Time" do
    @obj.time10.should be_an_instance_of(DateTime)
    @obj.time10.hour.should  eql(12)
    @obj.time10.min.should   eql(49)
    @obj.time10.sec.should   eql(45)
    @obj.time10.zone.should eql('-03:00')
  end

  it "should parse 'yyyy-mm-dd hh:mm:ss' as DateTime" do
    @obj.date1.should be_an_instance_of(DateTime)
    @obj.date1.year.should  eql(2008)
    @obj.date1.month.should eql(10)
    @obj.date1.day.should   eql(26)
    @obj.date1.hour.should  eql(12)
    @obj.date1.min.should   eql(49)
    @obj.date1.sec.should   eql(45)
    @obj.date1.zone.should eql('+00:00')
  end

  it "should properly parse booleans" do
    @obj.true.should eql(true)
    @obj.false.should eql(false )
  end

  it "should properly parse null" do
    @obj.null.should eql(nil)
    @obj.nil.should  eql(nil)
  end

  it "should properly handle nested objects" do
    @obj.nested.should respond_to("string")
    @obj.nested.string.should eql("textie")
    @obj.nested.should respond_to("int")
    @obj.nested.int.should eql(32)
  end

  it "should properly parse arrays" do
    @obj.array.should be_an_instance_of(Array)
    @obj.array.should eql(["item_1", 45.2, 1230.0])
  end
end
