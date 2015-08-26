begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Default Task is to RSpec code examples'
  task :default => :spec
rescue LoadError => error
  puts error
end
