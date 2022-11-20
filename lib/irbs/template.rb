# frozen_string_literal: true

module Irbs
  module Template
    class << self
      # @sig (YARD::CodeObjects::MethodObject) -> String
      def meth(meth)
        visibility = meth.visibility
        prefix = meth.scope == :class ? 'self.' : ''
        name = meth.name
        sig = meth.tag(:sig).text

        "  #{visibility} def #{prefix}#{name}: #{sig}"
      end

      # @sig (YARD::CodeObjects::ConstantObject) -> String
      def constant(constant)
        # visibility = constant.visibility
        name = constant.name
        sig = constant.tag(:sig).text

        "  #{name}: #{sig}"
      end

      # @sig (YARD::CodeObjects::ModuleObject) -> String
      def include(mod)
        "  include ::#{mod.path}"
      end

      # @sig (YARD::CodeObjects::ModuleObject) -> String
      def extend(mod)
        "  extend ::#{mod.path}"
      end

      # @sig (Irbs::AttributeWrapper) -> String
      def attribute(attr_wrapper)
        return '' unless attr_wrapper.sig

        visibility = attr_wrapper.visibility
        type = attr_wrapper.type
        prefix = attr_wrapper.scope == :class ? 'self.' : ''
        name = attr_wrapper.name
        sig = attr_wrapper.sig

        "  #{visibility} attr_#{type} #{prefix}#{name}: #{sig}"
      end
    end
  end
end
