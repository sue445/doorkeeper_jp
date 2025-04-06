# frozen_string_literal: true

# @!parse
#   module Hashie
#     # @see https://www.rubydoc.info/gems/hashie/Hashie/Hash
#     class Hash < ::Hash
#     end
#
#     # @see https://www.rubydoc.info/gems/hashie/Hashie/Mash
#     class Mash < Hash
#     end
#   end

module DoorkeeperJp
  require "hashie/mash"

  # Doorkeeper API response
  #
  # @see https://www.rubydoc.info/gems/hashie/Hashie/Hash
  # @see https://www.rubydoc.info/gems/hashie/Hashie/Mash
  class Response < Hashie::Mash
    disable_warnings
  end
end
