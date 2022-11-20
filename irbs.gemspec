# frozen_string_literal: true

require_relative 'lib/irbs/version'

Gem::Specification.new do |spec|
  spec.name = 'irbs'
  spec.version = Irbs::VERSION
  spec.authors = ['diaphragm']
  spec.email = ['7163746+diaphragm@users.noreply.github.com']

  spec.summary = 'Inline RBS'
  # spec.description = 'TODO: Write a longer description or delete this line.'
  spec.homepage = "https://github.com/diaphragm/irbs"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  # spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = "https://github.com/diaphragm"
  # spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__){
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}){|f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
