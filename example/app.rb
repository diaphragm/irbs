# frozen_string_literal: true

module Submodule
  def submethod
  end
end

module Example
  # @rbs type key = String | Symbol
  class App
    include Submodule
    extend Submodule

    module Hoge
      # @sig (Integer) -> String
      def self.hoge(arg)
        arg.to_s
      end

      class << self
        # @sig () -> bool
        def fuga
          false
        end
      end
    end

    HOGE = 'hoge'
    FUGA = 'fuga'
    private_constant :FUGA

    # @sig Integer
    attr_reader :xxx
    # @sig String
    attr_accessor :yyy

    class << self
      attr_reader :class_attr
    end

    # @sig (Integer, String) -> void
    def initialize(xxx, yyy)
      @xxx = xxx
      @yyy = yyy
    end

    # @sig () -> bool
    def foo
      false
    end

    # @sig () -> void
    def self.classmethod
    end

    private

    # @sig Array[untyped]
    attr_writer :zzz

    # @sig [T] (T) -> T
    def bar(zzz)
      zzz
    end
  end
end
