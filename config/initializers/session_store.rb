# セッションの期限は1週間
Rails.application.config.session_store :cookie_store, key: '_user_id_session', expire_after: 1.week