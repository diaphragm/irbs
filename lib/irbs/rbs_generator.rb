# frozen_string_literal: true

require 'forwardable'
require 'yard'

module Irbs
  class RbsGenerator
    extend Forwardable

    # @sig (YARD::CodeObjects::NamespaceObject, Irbs::Config) -> void
    def initialize(namespace_obj, config)
      @obj = namespace_obj
      @config = config
      @stdout = config.stdout
    end

    # @sig () -> void
    def generate
      writeout unless obj.root?

      child_namespaces.each do
        self.class.new(_1, config).generate
      end
    end

    private

    # @sig YARD::CodeObjects::NamespaceObject
    attr_reader :obj
    # @sig Irbs::Config
    attr_reader :config
    # @sig IO
    attr_reader :stdout

    # @!method instance_mixins
    #   @sig () -> Array[YARD::CodeObjects::ModuleObject]
    # @!method class_mixins
    #   @sig () -> Array[YARD::CodeObjects::ModuleObject]
    delegate %i[instance_mixins class_mixins] => :obj

    # @sig () -> void
    def writeout
      stdout.puts(to_rbs)
      stdout.puts
    end

    # @sig () -> String
    def to_rbs # rubocop:todo Metrics/AbcSize
      [
        namespace_definition,
        raw_rbses.map{ Template.rbs(_1) },
        class_mixins.map{ Template.extend(_1) },
        instance_mixins.map{ Template.include(_1) },
        config.ingore_constant ? nil : constants.map{ Template.constant(_1) },
        attributes.map{ Template.attribute(_1) },
        meths.map{ Template.meth(_1) },
        'end',
      ].flatten.compact.join("\n")
    end

    # @sig () -> String
    def namespace_definition
      "#{obj.type} ::#{obj.path}"
    end

    # @sig () -> Array[YARD::Tags::Tag]
    def raw_rbses
      obj.tags(:rbs)
    end

    # @sig () -> Array[YARD::CodeObjects::NamespaceObject]
    def child_namespaces
      # obj.children.select{ _1.kind_of?(YARD::CodeObjects::NamespaceObject) }
      # rewrite without #select to pass typecheck
      obj.children.each.with_object([]){|child, res|
        res.push(child) if child.is_a?(YARD::CodeObjects::NamespaceObject)
      }
    end

    # @sig () -> Array[YARD::CodeObjects::ConstantObject]
    def constants
      obj.constants.select{ _1.tag(:sig) }
    end

    # @sig () -> Array[YARD::CodeObjects::MethodObject]
    def meths
      (obj.meths - attribute_meths).select{ _1.tag(:sig) }
    end

    # @sig () -> Array[YARD::CodeObjects::MethodObject]
    def attribute_meths
      obj.attributes.values.map(&:values).flatten.map(&:values).flatten.compact
    end

    # @sig () -> Array[Irbs::AttributeWrapper]
    def attributes
      AttributeWrapper.parse(obj.attributes)
    end
  end
end
