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

task default: %i[rubocop typecheck test]

desc 'Setup develop environment'
task :setup do
  sh 'rbs collection install'
end

desc 'typecheck'
task :typecheck do
  sh 'mkdir -p sig'

  sh 'exe/irbs "lib/**/*.rb" -o sig/isig.rbs'
  sh 'steep check lib'
end

desc 'Example of usage with TypeProf and Steep'
task :example do
  sh 'exe/irbs example/app.rb -o example/irbs.rbs --ignore-constant'
  sh 'typeprof example/app.rb example/irbs.rbs -o example/typeprof.rbs'
  sh 'steep check example'
end
