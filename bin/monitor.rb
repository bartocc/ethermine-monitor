#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'
require 'active_support'

WORKERS_COUNT = 2
MINER = '1dE373F9C4C89FC061eA7a2a88d34721A83965a4'.freeze

class EthminerClient
  HOST = "api.ethermine.org"
end

url = "https://api.ethermine.org/miner/#{MINER}/workers"
uri = URI url
response = Net::HTTP.get uri
json = JSON.parse response

if json['data'].size == WORKERS_COUNT
  puts "#{WORKERS_COUNT} workers found"
  return
end

raise 'do something'
