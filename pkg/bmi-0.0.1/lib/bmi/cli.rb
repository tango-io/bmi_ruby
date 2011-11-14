require 'optparse'

module Bmi
  class CLI
    def self.calc(arguments=[])

      options = {
        :weight_k     => 0,
        :height_m     => 0,
        :weight_p     => 0,
        :height_i     => 0
      }
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
                "Default: ~") { |arg| options[:weight_k] = arg }


        opts.on("-b", "--height METERS", String,
                "How hight you are.",
                "Pleace introduce your height in meters.",
                "Default: ~") { |arg| options[:height_m] = arg }

        opts.on("-W", "--Weight POUNDS", String,
                "Your current weight.",
                "Pleace introduce your weight in pounds.",
                "Default: ~") { |arg| options[:weight_p] = arg }

        opts.on("-B", "--Height INCHES", String,
                "How hight you are.",
                "Pleace introduce your height in inches.",
                "Default: ~") { |arg| options[:height_i] = arg }

        opts.on("-h", "--help",
                "Show this help message.") { puts opts; exit }

        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          puts opts; exit
        end
      end

    return options
    end
  end
end
