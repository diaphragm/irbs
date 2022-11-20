# frozen_string_literal: true

module Irbs
  class AttributeWrapper
    # @sig (Hash[Symbol, Hash[Symbol, Hash[Symbol, YARD::CodeObjects::MethodObject?]]]) -> Array[Irbs::AttributeWrapper]
    def self.parse(attributes)
      attributes.map{|scope, attr_data|
        attr_data.map{|name, attr_meths| new(scope, name, attr_meths) }
      }.flatten
    end

    # @sig Symbol
    attr_reader :scope
    # @sig Symbol
    attr_reader :name
    # @sig YARD::CodeObjects::MethodObject?
    attr_reader :reader
    # @sig YARD::CodeObjects::MethodObject?
    attr_reader :writer

    # @sig (Symbol, Symbol, Hash[Symbol, YARD::CodeObjects::MethodObject?]) -> void
    def initialize(scope, name, attr_meths)
      @scope = scope
      @name = name
      @reader = attr_meths[:read]
      @writer = attr_meths[:write]
    end

    # @sig () -> Symbol
    def type
      if reader && writer
        :accessor
      elsif reader
        :reader
      elsif writer
        :writer
      else
        raise StandardError
      end
    end

    # @sig () -> Symbol?
    def visibility
      (reader || writer)&.visibility
    end

    # @sig () -> String?
    def sig
      (reader || writer)&.tag(:sig)&.text
    end
  end
end
