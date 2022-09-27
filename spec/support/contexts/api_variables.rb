shared_context :api_variables do
  let(:client) { DoorkeeperJp::Client.new(access_token) }
  let(:access_token) { "test_access_token" }

  let(:request_headers) do
    {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent" => "DoorkeeperJp v#{DoorkeeperJp::VERSION} (https://github.com/sue445/doorkeeper_jp)",
      "Authorization" => "Bearer #{access_token}",
      "Content-Type" => "application/json",
    }
  end

  let(:response_headers) { { "Content-Type" =>  "application/json" } }
end
