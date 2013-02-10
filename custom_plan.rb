require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def spinach_environment
    require 'spinach'
  end

  def spinach
    spinach_main = Spinach::Cli.new(ARGV.dup)
    exit spinach_main.run
  end

end

Zeus.plan = CustomPlan.new
