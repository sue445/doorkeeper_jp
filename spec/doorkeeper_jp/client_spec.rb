# frozen_string_literal: true

RSpec.describe DoorkeeperJp::Client do
  include_context :api_variables

  describe "#events" do
    context "with no params" do
      subject(:events) { client.events }

      before do
        stub_request(:get, "https://api.doorkeeper.jp/events").
          with(headers: request_headers).
          to_return(status: 200, headers: response_headers, body: fixture("get_events.json"), )
      end

      its(:count) { should eq 25 }

      describe "[1]" do
        subject { events[1] }

        its(:title)        { should eq "10/14（金）18:00～ 個別説明会／相談会（無料）" }
        its(:id)           { should eq 144271 }
        its(:starts_at)    { should eq "2022-10-14T09:00:00.000Z" }
        its(:ends_at)      { should eq "2022-10-14T10:00:00.000Z" }
        its(:venue_name)   { should eq "ＨＯＰＥ神田" }
        its(:address)      { should eq "東京都千代田区内神田2-12-5 3F" }
        its(:lat)          { should be_within(0.01).of(35.6914858) }
        its(:long)         { should be_within(0.01).of(139.7676934) }
        its(:ticket_limit) { should eq 1 }
        its(:published_at) { should eq "2022-09-27T12:01:00.585Z" }
        its(:updated_at)   { should eq "2022-09-27T12:01:00.591Z" }
        its(:description)  { should be_start_with "<h3>【説明・相談会の内容】</h3>" }
        its(:public_url)   { should eq "https://hope-it.doorkeeper.jp/events/144271" }
        its(:participants) { should eq 0 }
        its(:waitlisted)   { should eq 0 }

        its(:group) { should eq 12345 }
      end
    end

    context "with full params" do
      subject(:events) do
        client.events(
          page:            0,
          locale:          "ja",
          sort:            "starts_at",
          since_date:      Date.new(2022, 8, 1),
          until_date:      Date.new(2022, 8, 31),
          keyword:         "rails",
          prefecture:      "tokyo",
          is_expand_group: true,
        )
      end

      before do
        stub_request(:get, "https://api.doorkeeper.jp/events?page=0&locale=ja&sort=starts_at&since=2022-08-01&until=2022-08-31&q=rails&prefecture=tokyo&expand[]=group").
          with(headers: request_headers).
          to_return(status: 200, headers: response_headers, body: fixture("get_events_full_params.json"), )
      end

      its(:count) { should eq 5 }

      describe "[0]" do
        subject { events[0] }

        its(:title)        { should eq "[JAPANESE EVENT] 日本にあるグローバル企業でエンジニアとして働くには ？ 🚀" }
        its(:id)           { should eq 140863 }
        its(:starts_at)    { should eq "2022-08-03T10:00:00.000Z" }
        its(:ends_at)      { should eq "2022-08-03T11:00:00.000Z" }
        its(:venue_name)   { should eq "Impact Hub Tokyo" }
        its(:address)      { should eq "東京都目黒区目黒２丁目１１−３" }
        its(:lat)          { should be_within(0.01).of(35.6339419) }
        its(:long)         { should be_within(0.01).of(139.7081261) }
        its(:ticket_limit) { should eq 30 }
        its(:published_at) { should eq "2022-07-28T03:18:41.899Z" }
        its(:updated_at)   { should eq "2022-08-02T05:20:27.310Z" }
        its(:description)  { should be_start_with "<p>THIS EVENT WILL BE CONDUCTED IN JAPANESE ONLY!</p>" }
        its(:public_url)   { should eq "https://lewagontokyo.doorkeeper.jp/events/140863" }
        its(:participants) { should eq 6 }
        its(:waitlisted)   { should eq 0 }

        its([:group, :id])            { should eq 9136 }
        its([:group, :name])          { should eq "Le Wagon Tokyo - コーディングブートキャンプ" }
        its([:group, :country_code])  { should eq "JP" }
        its([:group, :logo])          { should eq "https://doorkeeper.jp/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBNTBQQlE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--5820b3555fb7c45f69dda6736b08c2e80a39d141/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjloYm1SZmNHRmtXd2RwQWNocEFjZz0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--e0e57e8ab7f02a9e57804bb53ef80c2bdc861848/Avatar%20Red.png" }
        its([:group, :description])   { should be_start_with "<p>Le Wagon Tokyoは学生を含めクリエイティブな方や起業を考えている方に最適なプログラミングスクールです。" }
        its([:group, :public_url])    { should eq "https://lewagontokyo.doorkeeper.jp/" }
        its([:group, :members_count]) { should eq 932 }
      end
    end
  end

  describe "#group_events" do
    subject(:events) { client.group_events(group: "esminc") }

    before do
      stub_request(:get, "https://api.doorkeeper.jp/groups/esminc/events").
        with(headers: request_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_group_events.json"), )
    end

    its(:count) { should eq 2 }

    describe "[0]" do
      subject { events[0] }

      its(:title)        { should eq "アジャイルカフェ@オンライン 第21回（※Zoom開催 耳だけOK）#AgileCafe" }
      its(:id)           { should eq 144272 }
      its(:starts_at)    { should eq "2022-10-18T08:30:00.000Z" }
      its(:ends_at)      { should eq "2022-10-18T09:00:00.000Z" }
      its(:venue_name)   { should eq nil }
      its(:address)      { should eq nil }
      its(:lat)          { should eq nil }
      its(:long)         { should eq nil }
      its(:ticket_limit) { should eq 50 }
      its(:published_at) { should eq "2022-09-27T13:10:40.485Z" }
      its(:updated_at)   { should eq "2022-09-27T13:29:40.142Z" }
      its(:description)  { should be_start_with "<p>視聴者の方から寄せられたアジャイルの悩みにアジャイルコーチが「あーでもない、こーでもない」「これならいけそうかも」と解決策を楽しく考えていきます。</p>" }
      its(:public_url)   { should eq "https://esminc.doorkeeper.jp/events/144272" }
      its(:participants) { should eq 1 }
      its(:waitlisted)   { should eq 0 }

      its(:group) { should eq 433 }
    end
  end

  describe "#group" do
    subject(:events) { client.group("trbmeetup") }

    before do
      stub_request(:get, "https://api.doorkeeper.jp/groups/trbmeetup").
        with(headers: request_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_group.json"), )
    end

    its(:id)            { should eq 24 }
    its(:name)          { should eq "Tokyo Rubyist Meetup" }
    its(:country_code)  { should eq "JP" }
    its(:logo)          { should eq "https://doorkeeper.jp/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBMUJqQVE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--9d2dfc7c9232ea39140864f2b9c8f95294beb690/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjloYm1SZmNHRmtXd2RwQWNocEFjZz0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--e0e57e8ab7f02a9e57804bb53ef80c2bdc861848/200px-Ruby_logo.png" }
    its(:description)   { should eq "<p>Tokyo Rubyist Meetup (trbmeetup)は、日本のRubyistと世界のRubyistとをつなげるための場になることを目指して設立されました。定例会には、東京近郊に住んでいる海外出身のRubyistたちと日本人Rubyistたちが参加します。例会の公用語は英語になりますが、英語が苦手な方も、一緒に英語の練習をするくらいのつもりでお気軽にご参加ください。</p>\n" }
    its(:public_url)    { should eq "https://trbmeetup.doorkeeper.jp/" }
    its(:members_count) { should eq 2155 }
  end

  describe "#event" do
    subject(:events) { client.event(id: 28319, is_expand_group: is_expand_group) }

    context "is_expand_group is false" do
      let(:is_expand_group) { false }

      before do
        stub_request(:get, "https://api.doorkeeper.jp/events/28319").
          with(headers: request_headers).
          to_return(status: 200, headers: response_headers, body: fixture("get_event.json"), )
      end

      its(:title)        { should eq "900K records per second with Ruby, Java, and JRuby" }
      its(:id)           { should eq 28319 }
      its(:starts_at)    { should eq "2015-08-13T10:00:00.000Z" }
      its(:ends_at)      { should eq "2015-08-13T13:00:00.000Z" }
      its(:venue_name)   { should eq "VOYAGE GROUP" }
      its(:address)      { should eq "東京都渋谷区神泉町8-16 渋谷ファーストプレイス8F" }
      its(:published_at) { should eq "2015-07-13T23:48:29.463Z" }
      its(:updated_at)   { should eq "2018-05-11T00:07:44.270Z" }
      its(:description)  { should be_start_with "<h2>アジェンダ</h2>" }
      its(:public_url)   { should eq "https://trbmeetup.doorkeeper.jp/events/28319" }
      its(:participants) { should eq 48 }
      its(:waitlisted)   { should eq 0 }
      its(:ticket_limit) { should eq 50 }
      its(:lat)          { should be_within(0.01).of(35.6552616) }
      its(:long)         { should be_within(0.01).of(139.6937299) }

      its(:group) { should eq 24 }
    end

    context "is_expand_group is true" do
      let(:is_expand_group) { true }

      before do
        stub_request(:get, "https://api.doorkeeper.jp/events/28319?expand[]=group").
          with(headers: request_headers).
          to_return(status: 200, headers: response_headers, body: fixture("get_event_expand_group.json"), )
      end

      its(:title)        { should eq "900K records per second with Ruby, Java, and JRuby" }
      its(:id)           { should eq 28319 }
      its(:starts_at)    { should eq "2015-08-13T10:00:00.000Z" }
      its(:ends_at)      { should eq "2015-08-13T13:00:00.000Z" }
      its(:venue_name)   { should eq "VOYAGE GROUP" }
      its(:address)      { should eq "東京都渋谷区神泉町8-16 渋谷ファーストプレイス8F" }
      its(:published_at) { should eq "2015-07-13T23:48:29.463Z" }
      its(:updated_at)   { should eq "2018-05-11T00:07:44.270Z" }
      its(:description)  { should be_start_with "<h2>アジェンダ</h2>" }
      its(:public_url)   { should eq "https://trbmeetup.doorkeeper.jp/events/28319" }
      its(:participants) { should eq 48 }
      its(:waitlisted)   { should eq 0 }
      its(:ticket_limit) { should eq 50 }
      its(:lat)          { should be_within(0.01).of(35.6552616) }
      its(:long)         { should be_within(0.01).of(139.6937299) }

      its([:group, :id])            { should eq 24 }
      its([:group, :name])          { should eq "Tokyo Rubyist Meetup" }
      its([:group, :country_code])  { should eq "JP" }
      its([:group, :logo])          { should eq "https://doorkeeper.jp/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBMUJqQVE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--9d2dfc7c9232ea39140864f2b9c8f95294beb690/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjloYm1SZmNHRmtXd2RwQWNocEFjZz0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--e0e57e8ab7f02a9e57804bb53ef80c2bdc861848/200px-Ruby_logo.png" }
      its([:group, :description])   { should be_start_with "<p>Tokyo Rubyist Meetup (trbmeetup)は、日本のRubyistと世界のRubyistとをつなげるための場になることを目指して設立されました。" }
      its([:group, :public_url])    { should eq "https://trbmeetup.doorkeeper.jp/" }
      its([:group, :members_count]) { should eq 2155 }
    end
  end
end
