# frozen_string_literal: true

module Irbs
  # @rbs def statement: () -> untyped
  module MonkeyPatch
    protected

    def process_mixin(mixin)
      super.tap do
        i = statement.method_name(true) == :include ? 0 : -1
        ident = statement[0].source
        _1[i].instance_variable_set(:@__ident, ident)
      end
    end
  end
end

class YARD::Handlers::Ruby::MixinHandler # rubocop:disable Style/ClassAndModuleChildren
  prepend ::Irbs::MonkeyPatch
end
