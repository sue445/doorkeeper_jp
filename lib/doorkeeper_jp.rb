# frozen_string_literal: true

require_relative "doorkeeper_jp/version"
require_relative "doorkeeper_jp/client"
require_relative "doorkeeper_jp/response"

require "faraday"
require "faraday/mashify"

module DoorkeeperJp
  class Error < StandardError; end

  # Create and returns {DoorkeeperJp::Client} instance
  #
  # @param access_token [String]
  #
  # @return [DoorkeeperJp::Client]
  def self.client(access_token = nil)
    DoorkeeperJp::Client.new(access_token)
  end
end
