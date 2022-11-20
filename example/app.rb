module Submodule
  def submethod
  end
end

module Example
  # @return AppApp
  class App
    include Submodule
    extend Submodule

    module Hoge
      # @sig (Integer) -> String
      def self.hoge(i)
        i.to_s
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
    attr_reader :x
    # @sig String
    attr_accessor :y

    class << self
      attr_reader :ca
    end

    # @sig (Integer, String) -> void
    def initialize(x, y)
      @x = x
      @y = y
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
    attr_writer :z

    def bar(zz)
      return zz
    end
  end
end
