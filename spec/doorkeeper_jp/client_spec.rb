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

        let(:description) do
          <<~MSG.strip
            <h3>【説明・相談会の内容】</h3>
  
            <ul>
            <li><p><strong>ＨＯＰＥ神田のご紹介</strong><br>
            　就労移行支援事業所HOPE神田での支援方法、訓練プログラムや就活支援の内容、<br>
            　就労実績、就職後の職場定着支援、余暇活動支援など</p></li>
            <li><p><strong>施設内のご見学</strong><br>
            　来所いただける場合は事業所内をご案内します。<br>
            　<strong>実際の訓練の様子を見学されたい方は</strong>、<br>
            　平日10:00-16:00での見学を、お電話または<a href=\"https://hope-it.or.jp/reserve/\" rel=\"nofollow\">ウェブフォーム</a>からご予約下さい。</p></li>
            <li><p><strong>個別相談</strong><br>
            　事業所の支援内容や就労支援に関するご質問を承ります。<br>
            　就職活動に関するご相談も承ります。お気軽にどうぞ！</p></li>
            </ul>
            
            <h3>【お申込みについて】</h3>
            
            <ul>
            <li><p>ひと組様ごとの個別のお申込みとなります。</p></li>
            <li><p>ご家族のみのご参加、またはご家族の同席も可能です。</p></li>
            <li><p>体験利用を希望される場合は、ご本人様の説明会への参加、または別途ご見学のための来所が必須になります。</p></li>
            <li><p>障害者手帳がなくてもご参加いただけます。ご本人が在学中の方もお気軽にご参加ください。</p></li>
            </ul>
            
            <h3>【感染予防へのご協力願い】</h3>
            
            <ul>
            <li><strong>37度以上の発熱や、のどの痛み、咳、寒気、吐き気、倦怠感など風邪の症状</strong>のある方は来所をご遠慮ください。</li>
            <li>当日の<strong>検温</strong>や<strong>消毒</strong>をお願いします。</li>
            <li><strong>マスク着用</strong>で来所ください。</li>
            </ul>
            
            <p>事業所の感染予防対策については、<a href=\"https://hope-it.or.jp/%E6%96%B0%E5%9E%8B%E3%82%B3%E3%83%AD%E3%83%8A%E3%82%A6%E3%82%A4%E3%83%AB%E3%82%B9%E3%81%AB%E4%BC%B4%E3%81%86%E6%96%BD%E8%A8%AD%E5%AF%BE%E5%BF%9C%E7%8A%B6%E6%B3%81/\" rel=\"nofollow\">こちら</a>をご覧ください。</p>
            
            <h3>【キャンセルについて】</h3>
            
            <p>キャンセルの際は、お申込みいただいた際に自動送信しております<br>
            チケットメールの [キャンセル] リンクをクリックしてください。</p>
            
            <h3>【当日の連絡先】</h3>
            
            <p>電話：03-5256-1411<br>
            メール：<a href=\"mailto:info@hope-it.or.jp\" rel=\"nofollow\">info@hope-it.or.jp</a></p>
            
            <h3>【オンラインをご希望の方】</h3>
            
            <p>ご利用説明会前日にお送りするリマインドメール（自動送信）とは別に、<br>
            当日のオンライン（Zoom）ミーティングURLを<br>
            ご登録のメールアドレス宛にお送りいたします。</p>
            
            <h3>【その他】</h3>
            
            <ul>
            <li><p>事業所の説明会のため、料金はもちろんいただいておりません。</p></li>
            <li><p>個人情報はご本人様の見学/相談や体験利用の目的以外に使用することはありません。</p></li>
            </ul>
          MSG
        end

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
        its(:description) { should eq description }
        its(:public_url) { should eq "https://hope-it.doorkeeper.jp/events/144271" }
        its(:participants) { should eq 0 }
        its(:waitlisted) { should eq 0 }
      end
    end
  end
end
