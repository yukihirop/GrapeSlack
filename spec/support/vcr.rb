VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  # VCRブロック外のHTTP通信は許可する
  c.allow_http_connections_when_no_cassette = true
  # vcr:trueで使えるようになる。
  c.configure_rspec_metadata!
end
