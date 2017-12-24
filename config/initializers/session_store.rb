# セッションの期限は1週間
Rails.application.config.session_store :active_record_store, key: '_your_app_name_session'
