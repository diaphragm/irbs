module Irbs
  class Config
    # @sig IO
    attr_accessor :stdout
    # @sig bool
    attr_accessor :ingore_constant
    # @sig Array[String]
    attr_accessor :paths

    def initialize
      @stdout = $stdout
      @ingore_constant = false
      @paths = []
    end
  end
end
