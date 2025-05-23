# frozen_string_literal: true

module DoorkeeperJp
  class Client
    # @param access_token [String]
    def initialize(access_token = nil)
      @access_token = access_token
    end

    # List all featured events
    #
    # @param page [Integer] The page offset of the results.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    # @param sort [String] The order of the results. One of `published_at`, `starts_at`, `updated_at`. Default: `published_at`.
    # @param since_date [Date] Only events taking place during or after this date will be included. Default: Today.
    # @param until_date [Date] Only events taking place during or before this date will be included.
    # @param keyword [String] Keyword to search for from the title or description fields.
    # @param prefecture [String] Only events with an address in prefecture.
    # @param is_expand_group [Boolean] Expands the group object.
    #
    # @return [Array<DoorkeeperJp::Response>]
    #
    # @see https://www.doorkeeper.jp/developer/api?locale=en
    def events(page: nil, locale: nil, sort: nil, since_date: nil, until_date: nil, keyword: nil, prefecture: nil, is_expand_group: false)
      get_events(
        path: "events",
        page: page, locale: locale, sort: sort, since_date: since_date, until_date: until_date,
        keyword: keyword, prefecture: prefecture, is_expand_group: is_expand_group,
      )
    end

    # List a community's events
    #
    # @param group [String]
    # @param page [Integer] The page offset of the results.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    # @param sort [String] The order of the results. One of `published_at`, `starts_at`, `updated_at`. Default: `published_at`.
    # @param since_date [Date] Only events taking place during or after this date will be included. Default: Today.
    # @param until_date [Date] Only events taking place during or before this date will be included.
    # @param keyword [String] Keyword to search for from the title or description fields.
    # @param prefecture [String] Only events with an address in prefecture.
    # @param is_expand_group [Boolean] Expands the group object.
    #
    # @return [Array<DoorkeeperJp::Response>]
    #
    # @see https://www.doorkeeper.jp/developer/api?locale=en
    def group_events(group, page: nil, locale: nil, sort: nil, since_date: nil, until_date: nil, keyword: nil, prefecture: nil, is_expand_group: false)
      get_events(
        path: "groups/#{group}/events",
        page: page, locale: locale, sort: sort, since_date: since_date, until_date: until_date,
        keyword: keyword, prefecture: prefecture, is_expand_group: is_expand_group,
      )
    end

    # Show a specific group
    #
    # @param group [String]
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    #
    # @return [DoorkeeperJp::Response]
    #
    # @see https://www.doorkeeper.jp/developer/api?locale=en
    def group(group, locale: nil)
      params = {
        locale: locale,
      }.compact

      res = connection.get("groups/#{group}", params).body
      res["group"]
    end

    # Show a specific event
    #
    # @param id [Integer]
    # @param is_expand_group [Boolean] Expands the group object.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    #
    # @return [DoorkeeperJp::Response]
    #
    # @see https://www.doorkeeper.jp/developer/api?locale=en
    def event(id, is_expand_group: false, locale: nil)
      params = {
        locale: locale,
      }.compact #: Hash[Symbol|String, untyped]

      params["expand[]"] = "group" if is_expand_group

      res = connection.get("events/#{id}", params).body
      res["event"]
    end

    private

    # @param path [String]
    # @param page [Integer] The page offset of the results.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    # @param sort [String] The order of the results. One of `published_at`, `starts_at`, `updated_at`. Default: `published_at`.
    # @param since_date [Date] Only events taking place during or after this date will be included. Default: Today.
    # @param until_date [Date] Only events taking place during or before this date will be included.
    # @param keyword [String] Keyword to search for from the title or description fields.
    # @param prefecture [String] Only events with an address in prefecture.
    # @param is_expand_group [Boolean] Expands the group object.
    #
    # @return [Array<DoorkeeperJp::Response>]
    def get_events(path:, page:, locale:, sort:, since_date:, until_date:, keyword:, prefecture:, is_expand_group:)
      params = event_params(
        page: page, locale: locale, sort: sort, since_date: since_date, until_date: until_date,
        keyword: keyword, prefecture: prefecture, is_expand_group: is_expand_group,
      )

      res = connection.get(path, params).body
      res.map(&:event) # steep:ignore
    end

    # @return [Faraday::Connection]
    def connection
      Faraday.new(url: "https://api.doorkeeper.jp/", headers: request_headers) do |conn|
        conn.response :mashify, mash_class: DoorkeeperJp::Response
        conn.response :json
        conn.response :raise_error

        conn.adapter Faraday.default_adapter
      end
    end

    # @return [Hash]
    def request_headers
      headers =
        {
          "User-Agent" => "DoorkeeperJp v#{DoorkeeperJp::VERSION} (https://github.com/sue445/doorkeeper_jp)",
          "Content-Type" => "application/json",
        }

      headers["Authorization"] = "Bearer #{@access_token}" if @access_token

      headers
    end

    # @param page [Integer] The page offset of the results.
    # @param locale [String] The localized text for an event. One of `en`, `ja`. Default: `ja`.
    # @param sort [String] The order of the results. One of `published_at`, `starts_at`, `updated_at`. Default: `published_at`.
    # @param since_date [Date] Only events taking place during or after this date will be included. Default: Today.
    # @param until_date [Date] Only events taking place during or before this date will be included.
    # @param keyword [String] Keyword to search for from the title or description fields.
    # @param prefecture [String] Only events with an address in prefecture.
    # @param is_expand_group [Boolean] Expands the group object.
    #
    # @return [Hash]
    def event_params(page:, locale:, sort:, since_date:, until_date:, keyword:, prefecture:, is_expand_group:)
      params = {
        page:       page,
        locale:     locale,
        sort:       sort,
        since:      to_ymd(since_date),
        until:      to_ymd(until_date),
        q:          keyword,
        prefecture: prefecture
      }.compact #: Hash[Symbol|String, untyped]

      params["expand[]"] = "group" if is_expand_group

      params
    end

    # @param date [Date]
    #
    # @return [String]
    def to_ymd(date)
      date&.strftime("%Y-%m-%d")
    end
  end
end
