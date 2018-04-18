require "rubygems"
require "bundler/setup"
Bundler.require
require "uri"

target = URI(ENV.fetch("TARGET")).to_s

use Rack::ReverseProxy do
  reverse_proxy "/", target
end

use Rack::SslEnforcer

run lambda { |env|
  [500, { "Content-Type" => "text/html; charset=utf-8" }, StringIO.new("Something's gone horribly wrong!")]
}
