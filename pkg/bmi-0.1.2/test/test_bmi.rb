require File.dirname(__FILE__) + '/test_helper.rb'
require 'test/unit'
require 'bmi'
class TestBmi < Test::Unit::TestCase

  #def setup
  #end
  @@bmi=BMI.new
  
  def test_truth
    assert true
  end

  def test_metric
    @@bmi.calc(['-w 60','-b 1.70'])
    assert_equal(true,@@bmi.metric)
  end

  def test_imperial
    @@bmi.calc(['-W 189','-B 69.88'])
    assert_equal(true,@@bmi.imperial)
  end

  def test_get_prime
    @@bmi.calc(['-w 60','-b 1.70'])
    assert_equal("17%",@@bmi.get_prime)
  end

  def test_categories_cases
    cases={'Underweight'     =>['-w 50','-b 1.70'],
           'Normal'          =>['-w 60','-b 1.70'],
           'Overweight'      =>['-w 75','-b 1.70'],
           'Obese Class I'   =>['-w 90','-b 1.70'],
           'Obese Class II'  =>['-w 105','-b 1.70'],
           'Obese Class III' =>['-w 120','-b 1.70']}

    cases.each do |k,v| 
      @@bmi.calc(v)
      assert_equal(k,@@bmi.cases)
    end
  end
end
