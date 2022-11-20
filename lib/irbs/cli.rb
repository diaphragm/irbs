require 'optparse'

module Irbs
  class CLI
    # @sig (Array[String]) -> void
    def self.run(argv)
      config = Irbs::Config.new
      opt = OptionParser.new

      opt.on('-o output', 'default: stdout') do
        config.stdout = File.open(_1, 'w')
      end
      opt.on('--ignore-constant', 'Generate no constant signatures. For using TypeProf. (TypeProf genarate duplicate constant signature even if already exists.)') do
        config.ingore_constant = _1
      end
      config.paths = opt.parse(argv)

      Core.new(config).generate
      config.stdout.close
    end
  end
end
