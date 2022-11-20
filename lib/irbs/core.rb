# frozen_string_literal: true

require 'yard'

module Irbs
  class Core
    # @sig Irbs::Config
    attr_reader :config

    # @sig (Irbs::Config) -> void
    def initialize(config)
      @config = config

      YARD::Tags::Library.define_tag('Signature', :sig)
      YARD.parse(config.paths)
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
