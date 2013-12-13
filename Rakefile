require "bundler/gem_tasks"
require "rake/testtask"
require "rdoc/task"
$:.unshift File.dirname(__FILE__) + 'lib'
$:.unshift './lib', './spec'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Run rspec with format: html"
task :thtml do
  sh "rspec -Ilib spec/Matriz_spec.rb --format html > index.html"
  sh "rspec -Ilib spec/MatrizDSL_spec.rb --format html > index2.html"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/tc*.rb']
  t.verbose = true
end

RDoc::Task.new do |rdoc|
  rdoc.options << "all"
end
