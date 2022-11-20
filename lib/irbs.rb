# frozen_string_literal: true

require_relative 'irbs/attribute_wrapper'
require_relative 'irbs/cli'
require_relative 'irbs/config'
require_relative 'irbs/core'
require_relative 'irbs/rbs_generator'
require_relative 'irbs/template'
require_relative 'irbs/version'

module Irbs
  class Error < StandardError; end
  # Your code goes here...
end
