require 'rake/testtask'

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.libs << 'test'
end


begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "moxie_forum"
    gem.summary = "Fantastic forum software for Rails 3"
    gem.email = "krschacht@gmail.com"
    gem.authors = ["Keith Schacht"]
    gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue
  puts "Jeweler or dependency not available."
end
