# frozen_string_literal: true

RSpec.describe DoorkeeperJp::Client do
  include_context :api_variables

  describe "#events" do
    context "with no args" do
      subject(:events) { client.events }

      before do
        stub_request(:get, "https://api.doorkeeper.jp/events").
          with(headers: request_headers).
          to_return(status: 200, headers: response_headers, body: fixture("get_events.json"), )
      end

      its(:count) { should eq 25 }

      describe "[1]" do
        subject { events[1] }

        its(:title) { should eq "10/14（金）18:00～ 個別説明会／相談会（無料）" }
        its(:id) { should eq 144271 }
        its(:starts_at) { should eq "2022-10-14T09:00:00.000Z" }
        its(:ends_at) { should eq "2022-10-14T10:00:00.000Z" }
        its(:venue_name) { should eq "ＨＯＰＥ神田" }
        its(:address) { should eq "東京都千代田区内神田2-12-5 3F" }
        its(:lat) { should be_within(0.01).of(35.6914858) }
        its(:long) { should be_within(0.01).of(139.7676934) }
        its(:ticket_limit) { should eq 1 }
        its(:published_at) { should eq "2022-09-27T12:01:00.585Z" }
        its(:updated_at) { should eq "2022-09-27T12:01:00.591Z" }
        its(:group) { should eq 12345 }
        its(:description) { should be_start_with "<h3>【説明・相談会の内容】</h3>" }
        its(:public_url) { should eq "https://hope-it.doorkeeper.jp/events/144271" }
        its(:participants) { should eq 0 }
        its(:waitlisted) { should eq 0 }
      end
    end

    context "with full params" do
      subject(:events) do
        client.events(
          page: 0,
          locale: "ja",
          sort: "starts_at",
          since_date: Date.new(2022, 8, 1),
          until_date: Date.new(2022, 8, 31),
          keyword: "rails",
          prefecture: "tokyo",
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

        its(:title) { should eq "[JAPANESE EVENT] 日本にあるグローバル企業でエンジニアとして働くには ？ 🚀" }
        its(:id) { should eq 140863 }
        its(:starts_at) { should eq "2022-08-03T10:00:00.000Z" }
        its(:ends_at) { should eq "2022-08-03T11:00:00.000Z" }
        its(:venue_name) { should eq "Impact Hub Tokyo" }
        its(:address) { should eq "東京都目黒区目黒２丁目１１−３" }
        its(:lat) { should be_within(0.01).of(35.6339419) }
        its(:long) { should be_within(0.01).of(139.7081261) }
        its(:ticket_limit) { should eq 30 }
        its(:published_at) { should eq "2022-07-28T03:18:41.899Z" }
        its(:updated_at) { should eq "2022-08-02T05:20:27.310Z" }
        its([:group, :id]) { should eq 9136 }
        its([:group, :name]) { should eq "Le Wagon Tokyo - コーディングブートキャンプ" }
        its([:group, :country_code]) { should eq "JP" }
        its([:group, :logo]) { should eq "https://doorkeeper.jp/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBNTBQQlE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--5820b3555fb7c45f69dda6736b08c2e80a39d141/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjloYm1SZmNHRmtXd2RwQWNocEFjZz0iLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--e0e57e8ab7f02a9e57804bb53ef80c2bdc861848/Avatar%20Red.png" }
        its([:group, :description]) { should be_start_with "<p>Le Wagon Tokyoは学生を含めクリエイティブな方や起業を考えている方に最適なプログラミングスクールです。" }
        its([:group, :public_url]) { should eq "https://lewagontokyo.doorkeeper.jp/" }
        its([:group, :members_count]) { should eq 932 }
        its(:description) { should be_start_with "<p>THIS EVENT WILL BE CONDUCTED IN JAPANESE ONLY!</p>" }
        its(:public_url) { should eq "https://lewagontokyo.doorkeeper.jp/events/140863" }
        its(:participants) { should eq 6 }
        its(:waitlisted) { should eq 0 }
      end
    end
  end
end
