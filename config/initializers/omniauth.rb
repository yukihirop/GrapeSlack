# ERROR -- omniauth: (slack) Authentication failure! invalid_credentials encountered.
# 対策
OmniAuth.config.logger = Rails.logger

# 認証キャンセルの時にリダイレクト
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}