Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
           ENV['SLACK_API_KEY'], ENV['SLACK_API_SECRET'],
           scope: 'client'
end

# 認証キャンセルの時にリダイレクト
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

# ERROR -- omniauth: (slack) Authentication failure! invalid_credentials encountered.
# 対策
OmniAuth.config.logger = Rails.logger