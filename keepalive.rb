require 'rubygems'
require 'clockwork'
require 'httparty'

include Clockwork

if ENV['INTERVAL']
  interval = ENV['INTERVAL'].to_i
  abort "INTERVAL must be value in seconds greater than 0" unless interval > 0
else
  interval = 10
end

abort "ENDPOINTS must be comma-separated list of http endpoints to query for keepalive" unless ENV['ENDPOINTS']

every(interval, 'ping') {
  ENV['ENDPOINTS'].split(",").each do |endpoint|
    s = Time.now
    HTTParty.get(endpoint)
    duration = (Time.now - s).to_f * 1000
    puts "Contacted #{endpoint} in #{duration.round}ms"
  end
}
