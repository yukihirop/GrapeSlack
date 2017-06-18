require 'rails_helper'

describe 'Contentsページ', type: :feature, vcr: { cassette_name: 'add_content' } do
  subject { page }

  context 'Slack URLが空' do
    include_context 'add_summary_content_with_slack_urls_blank'

    it 'エラーメッセージが表示される(３つ)' do
      is_expected.to have_css('div.alert-danger', I18n.t('user.summaries.errors.invalid_slack_urls'))
      is_expected.to have_css('li',               I18n.t('errors.format', {  default: '%{attribute} %{message}',
                                                                             attribute: 'Slack url',
                                                                             message: I18n.t('errors.messages.required') }))
      is_expected.to have_css('li',               I18n.t('errors.format', {  default: '%{attribute}%{message}',
                                                                             attribute: 'Slack url',
                                                                             message: I18n.t('errors.messages.invalid') }))
    end
  end

  context 'Slack URLが有効でない' do
    include_context 'add_summary_content_with_slack_urls_invalid'

    it 'エラーメッセージが表示される(1つ)' do
      is_expected.to have_css('div.alert-danger', text: I18n.t('user.summaries.errors.channel_invalid_slack_urls', Settings.slack[:permit_channel]))
    end

  end

end
