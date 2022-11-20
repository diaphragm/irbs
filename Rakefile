# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test rubocop]

desc 'typecheck'
task :typecheck do
  require 'fileutils'
  require_relative 'lib/irbs'
  require 'steep'
  require 'steep/cli'

  FileUtils.mkdir_p('isig')
  Irbs::CLI.run(['lib/**/*.rb', '-o', 'isig/irbs.rbs'])
  Steep::CLI.new(argv: %w[check lib], stdout: $stdout, stderr: $stderr, stdin: $stdin).run
end

desc 'Exapmle of usage with TypeProf and Steep'
task :example do
  require_relative 'lib/irbs'
  require 'typeprof'
  require 'steep'
  require 'steep/cli'

  Irbs::CLI.run(['example/app.rb', '-o', 'example/irbs.rbs', '--ignore-constant'])
  TypeProf.analyze(TypeProf::CLI.parse(['example/app.rb', 'example/irbs.rbs', '-o', 'example/typeprof.rbs']))
  Steep::CLI.new(argv: %w[check example], stdout: $stdout, stderr: $stderr, stdin: $stdin).run
end
