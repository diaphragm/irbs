# frozen_string_literal: true

require 'yard'

module Irbs
  class Core
    # @sig Irbs::Config
    attr_reader :config

    # @sig (Irbs::Config) -> void
    def initialize(config)
      @config = config

      # YARD::Parser::SourceParser.after_parse_file do |parser|
      #   next unless parser.file == 'example/app.rb'
      #   $parser = parser.instance_variable_get(:@parser)
      # end

      YARD::Tags::Library.define_tag('Signature', :sig)
      YARD::Tags::Library.define_tag('Raw rbs code', :rbs)

      YARD::Parser::SourceParser.parse(config.paths)
      YARD::Registry.load_all
    end

    # @sig () -> void
    def generate
      config.stdout.puts("# Irbs #{VERSION}")
      config.stdout.puts
      RbsGenerator.new(registry.root, config).generate
    end

    private

    # @sig () -> singleton(YARD::Registry)
    def registry
      YARD::Registry
    end
  end
end
