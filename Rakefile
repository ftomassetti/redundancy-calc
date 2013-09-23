require 'rake/testtask'
require 'rubygems/tasks'
require 'cucumber'
require 'cucumber/rake/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

Gem::Tasks.new do |tasks|
  tasks.console.command = 'jruby'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end

desc "Run tests"
task :default => [:test, :features]
