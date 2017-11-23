#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'
require 'active_support'

WORKERS_COUNT = 2
MINER = '1dE373F9C4C89FC061eA7a2a88d34721A83965a4'.freeze

class EthminerClient
  SCHEME = 'https'.freeze
  HOST = 'api.ethermine.org'.freeze

  def self.url(path)
    "#{SCHEME}://#{HOST}#{path}"
  end

  def initialize(miner)
    @miner = miner
  end

  def workers_json
    path = "/miner/#{@miner}/workers"
    uri = URI self.class.url(path)
    JSON.parse Net::HTTP.get(uri)
  end

  def workers
    workers_json['data'].map do |hash|
      Worker.new hash
    end
  end

  def workers_count
    workers.size
  end

  def worker_names
    workers.map(&:worker)
  end
end

class Worker < OpenStruct
end

client = EthminerClient.new(MINER)
puts client.workers_count
puts client.worker_names
