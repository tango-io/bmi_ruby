$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'optparse'

class BMI

  attr_accessor :data, :metric, :imperial, :bmi, :metric, :percent

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
    @percent  = 0
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

  def get_imperial
    @bmi =( ( @weight ) / ( @height * @height ) ) * 703
  end

  def get_metric
    @bmi =( @weight ) / ( @height * @height )
  end

  def get_prime
    @prime = ( @bmi / 25 )
    prcnt = (@prime.to_s).match(/\.\d{0,2}/)
    prcnt = (prcnt[0]).match(/\d{1,2}/)
    puts "Your body mass index is: #{@bmi.round}"
    
    @percent=prcnt[0].to_i
    if @prime.to_i <= 0
      @percent=100 - @percent
      puts "You are #{@percent}% under your ideal weight"
    else
      puts "You are #{@percent}% over your ideal weight"
    end
    return @percent.to_s+"%"
  end

  def cases
    case
    when @bmi < 18.5
      msj= "Underweight"
    when @bmi.between?(18.5,24.9)
      msj= "Normal"
    when @bmi.between?(25,29.9)
      msj= "Overweight"
    when @bmi.between?(30,35)
      msj= "Obese Class I"
    when @bmi.between?(35,40)
      msj= "Obese Class II"
    when @bmi > 40
      msj= "Obese Class III"
    end
    return msj
  end

  def calc(arguments=[])

    loadata(arguments) 
    determinates() 

    if @imperial 
      get_imperial()
      get_prime()
      cases()
    end

    if @metric
      get_metric()
      get_prime()
      cases()
    end
    
  end

  VERSION = '0.1.1'
end
 
