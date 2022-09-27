# frozen_string_literal: true

require_relative "doorkeeper_jp/version"
require_relative "doorkeeper_jp/client"
require_relative "doorkeeper_jp/response"

require "faraday"
require "faraday/mashify"

module DoorkeeperJp
  class Error < StandardError; end
  # Your code goes here...
end
