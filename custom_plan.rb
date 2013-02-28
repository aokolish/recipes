require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def spinach_environment
    require 'spinach'
  end

  def spinach
    spinach_main = Spinach::Cli.new(ARGV.dup)
    exit spinach_main.run
  end

  def test
    SimpleCov.start
    ENV["ZEUS_RUN"] = 'true'
    # you may need to load other files...
    Dir["#{Rails.root}/app/helpers/**/*.rb"].each { |f| load f }
    super
  end

end

Zeus.plan = CustomPlan.new
