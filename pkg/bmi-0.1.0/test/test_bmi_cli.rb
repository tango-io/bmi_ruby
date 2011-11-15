require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'bmi/cli'

class TestBmiCli < Test::Unit::TestCase
  
  def setup
    Bmi::CLI.calc([])
  end
  
  def test_kilograms
    data = Bmi::CLI.calc(['-w 80'])
    kilograms = data[:weight_k].to_f
    assert_equal(80, kilograms)
  end

  def test_meters
    data = Bmi::CLI.calc(['-b 1.80'])
    meters = data[:height_m].to_f
    assert_equal(1.80, meters)
  end

  def test_pounds
    data = Bmi::CLI.calc(['-W 166'])
    pounds = data[:weight_p].to_f
    assert_equal(166, pounds)
  end

  def test_inches
    data = Bmi::CLI.calc(['-B 68.11'])
    inches = data[:height_i].to_f
    assert_equal(68.11, inches)
  end
end
