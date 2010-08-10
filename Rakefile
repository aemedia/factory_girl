require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'date'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the factory_girl plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the factory_girl plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Factory Girl'
  rdoc.options << '--line-numbers' << '--inline-source' << "--main" << "README.textile"
  rdoc.rdoc_files.include('README.textile')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Update documentation on website'
task :sync_docs => 'rdoc' do
  `rsync -ave ssh rdoc/ dev@dev.thoughtbot.com:/home/dev/www/dev.thoughtbot.com/factory_girl`
end

spec = Gem::Specification.new do |s|
  s.name        = %q{factory_girl}
  s.version     = "1.1"
  s.summary     = %q{factory_girl provides a framework and DSL for defining and
                     using model instance factories.}
  s.description = %q{factory_girl provides a framework and DSL for defining and
                     using factories - less error-prone, more explicit, and 
                     all-around easier to work with than fixtures.}

  s.files        = FileList['[A-Z]*', 'lib/**/*.rb', 'test/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir[*['test/**/*_test.rb']]

  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.textile"]
  s.rdoc_options = ['--line-numbers', '--inline-source', "--main", "README.textile"]

  s.authors = ["Joe Ferris"]
  s.email   = %q{jferris@thoughtbot.com}

  s.platform = Gem::Platform::RUBY
  s.add_dependency(%q<activesupport>, [">= 1.0"])
end

Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

desc "Clean files generated by rake tasks"
task :clobber => [:clobber_rdoc, :clobber_package]

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
