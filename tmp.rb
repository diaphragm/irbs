require_relative 'lib/irbs'

core = Irbs::Core.new('{lib,example}/**/*.rb')
app = core.registry.at('Example::App')
cm = core.registry.at('Example::App::Hoge.hoge')
root = core.registry.root
generator = Irbs::RbsGenerator.new(root, File.open('isig/irbs.rbs', 'w'))
generator.run

# generator = Irbs::RbsGenerator.new(app, $stdout)
# binding.irb
