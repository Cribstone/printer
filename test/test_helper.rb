require "minitest/autorun"
require "rubygems"
require "bundler"
Bundler.require(:default, :test)

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "jobs"

def fixture_path(filename)
  File.expand_path("../fixtures/#{filename}", __FILE__)
end