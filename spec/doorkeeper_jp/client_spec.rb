# frozen_string_literal: true

RSpec.describe DoorkeeperJp::Client do
  let(:client) { DoorkeeperJp::Client.new }

  describe "#events" do
    context "with no args" do
      subject(:events) { client.events }

      its(:count) { should eq 10 }

      describe "[0]" do
        its(:title) { should eq "" }
        its(:id) { should eq 0 }
        its(:starts_at) { should eq "" }
        its(:ends_at) { should eq "" }
        its(:venue_name) { should eq "" }
        its(:address) { should eq "" }
        its(:lat) { should eq "" }
        its(:long) { should eq "" }
        its(:ticket_limit) { should eq "" }
        its(:published_at) { should eq "" }
        its(:updated_at) { should eq "" }
        its(:group) { should eq 0 }
        its(:description) { should eq "" }
        its(:public_url) { should eq "" }
        its(:participants) { should eq 0 }
        its(:waitlisted) { should eq 0 }
      end
    end
  end
end
