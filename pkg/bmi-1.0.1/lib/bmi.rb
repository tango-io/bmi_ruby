$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'optparse'

class BMI

  attr_accessor :data

  def initialize(data={})    
    @data = data
    @data = {
      :weight_k     => 0,
      :height_m     => 0,
      :weight_p     => 0,
      :height_i     => 0
    }
    @imperial = false
    @metric   = false
    @weight   = 0
    @height   = 0
    @bmi      = 0
    @prime    = 0
  end

  def loadata(arguments=[])
    mandatory_options = %w(  )

    parser = OptionParser.new do |opts|
      opts.banner = <<-BANNER.gsub(/^          /,'')
          Body Mass Index [BMI] help guide

          Usage: #{File.basename($0)} [options]

          Options are:
      BANNER
      opts.separator ""

      opts.on("-w", "--weight KILOGRAMS", String,
              "Your current weight.",
              "Pleace introduce your weight in kilograms.",
              "Default: ~") { |arg| @data[:weight_k] = arg }


      opts.on("-b", "--height METERS", String,
              "How hight you are.",
              "Pleace introduce your height in meters.",
              "Default: ~") { |arg| @data[:height_m] = arg }

      opts.on("-W", "--Weight POUNDS", String,
              "Your current weight.",
              "Pleace introduce your weight in pounds.",
              "Default: ~") { |arg| @data[:weight_p] = arg }

      opts.on("-B", "--Height INCHES", String,
              "How hight you are.",
              "Pleace introduce your height in inches.",
              "Default: ~") { |arg| @data[:height_i] = arg }

      opts.on("-h", "--help",
              "Show this help message.") { puts opts}

      opts.parse!(arguments)

      if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
        puts opts
      end

    end
  end

  def determinates
    @data.select!{|k,v| v.to_f > 0}
    @imperial = true if @data[:weight_p] && @data[:height_i]
    @metric   = true if @data[:weight_k] && @data[:height_m]
    @weight = @data[:weight_k] || @data[:weight_p]  
    @height = @data[:height_m] || @data[:height_i]  
    @weight = @weight.to_f
    @height = @height.to_f
  end

  def imperial
    @bmi =( ( @weight ) / ( @height * @height ) ) * 703
  end

  def metric
    @bmi =( @weight ) / ( @height * @height )
  end

  def prime
    @prime = ( @bmi / 25 )
    prcnt = (@prime.to_s).match(/\.\d./)
    prcnt = (prcnt[0]).match(/\d./)
    puts "Your body mass index is: #{@bmi.round}"

    if @prime.to_i <= 0
      puts "You are #{100 - prcnt[0].to_i}% under your ideal weight"
    else
      puts "You are #{prcnt[0].to_i}% over your ideal weight"
    end
  end

  def cases
    case
    when @bmi < 18.5
      puts "Underweight"
    when @bmi.between?(18.5,24.9)
      puts "Normal"
    when @bmi.between?(25,29.9)
      puts "Overweight"
    when @bmi.between?(30,35)
      puts "Obese Class I"
    when @bmi.between?(35,40)
      puts "Obese Class II"
    when @bmi > 40
      puts "Obese Class III"
    end
  end

  def calc(arguments=[])

    loadata(arguments) 
    determinates() 

    if @imperial 
      imperial()
      prime()
      cases()
    end

    if @metric
      metric()
      prime()
      cases()
    end
    
  end

  VERSION = '1.0.1'
end
 
