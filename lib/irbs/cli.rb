# frozen_string_literal: true

require 'optparse'

module Irbs
  class CLI
    # @sig String
    IGNORE_CONSTANT_HELP_MESSAGE = 'Generate no constant signatures. ' \
      'For using TypeProf. ' \
      '(TypeProf genarate duplicate constant signature even if already exists.)'
    private_constant :IGNORE_CONSTANT_HELP_MESSAGE

    class << self
      # @sig (Array[String]) -> void
      def run(argv)
        config = parse_opt(argv)
        Core.new(config).generate
      ensure
        config&.stdout&.close
      end

      private

      # @sig (Array[String]) -> Irbs::Config
      def parse_opt(argv)
        config = Irbs::Config.new
        opt = OptionParser.new

        opt.on('-o output', 'Output filename. (Default: stdout)') do
          config.stdout = File.open(_1, 'w')
        end
        opt.on('--ignore-constant', IGNORE_CONSTANT_HELP_MESSAGE) do
          config.ingore_constant = _1
        end
        config.paths = opt.parse(argv)

        config
      end
    end
  end
end
