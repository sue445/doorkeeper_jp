# frozen_string_literal: true

module DoorkeeperJp
  class Client
    # List all featured events
    #
    # @param page [Integer] The page offset of the results.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    # @param sort [String] The order of the results. One of `published_at`, `starts_at`, `updated_at`. Default: `published_at`.
    # @param since [Date] Only events taking place during or after this date will be included. (ISO 8601 date) Default: Today.
    # @param until [Date] Only events taking place during or before this date will be included. (ISO 8601 date)
    # @param keyword [String] Keyword to search for from the title or description fields.
    # @param prefecture [String] Only events with an address in prefecture.
    # @param is_expand_group [Boolean] Expands the group object.
    #
    # @return [Array<DoorkeeperJp::Response>]
    #
    # @see https://www.doorkeeper.jp/developer/api?locale=en
    def events(page: nil, locale: nil, sort: nil, since: nil, until: nil, keyword: nil, prefecture: nil, is_expand_group: false)
      # TODO: Impl
      []
    end
  end
end
