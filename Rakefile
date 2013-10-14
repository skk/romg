# encoding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'romg/version'
version = ROMG::Version::VERSION

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "romg"
  gem.homepage = "http://github.com/skk/romg"
  gem.license = "MIT"
  gem.summary = %Q{Generate Diagrams of the Ruby Object Model}
  gem.description = %Q{Generate Diagrams of the Ruby Object Model}
  gem.email = "steven@knight.cx"
  gem.authors = ["Steven Knight"]
  gem.version = version
  gem.executables   = ["romg"]
  gem.require_paths = ["lib"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "romg #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end