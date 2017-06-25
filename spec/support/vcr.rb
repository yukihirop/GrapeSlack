VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr'
  config.hook_into :webmock
  # VCRブロック外のHTTP通信は許可する
  config.allow_http_connections_when_no_cassette = true
  # vcr:trueで使えるようになる。
  config.configure_rspec_metadata!
  config.debug_logger = File.open('log/vcr.log', 'w')
end
