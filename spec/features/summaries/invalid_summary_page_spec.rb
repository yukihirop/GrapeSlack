require 'rails_helper'

describe 'Summariesページ', type: :feature, vcr: { cassette_name: 'create_summary' } do

  subject { page }

  context 'TitleもSlack URLも空' do
    include_context 'create_summary_with_blank'

    it 'エラーメッセージが表示される(4つ)' do
      is_expected.to have_css('div.alert-danger', I18n.t('user.summaries.errors.invalid_slack_urls'))
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Contents slack url',
                                                                            message: I18n.t(:'errors.messages.required') }))
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Contents slack url',
                                                                            message: I18n.t(:'errors.messages.invalid') }))
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Title',
                                                                            message: I18n.t(:'errors.messages.required') }))
    end
  end

  context 'Slack URLが空' do
    include_context 'create_summary_with_slack_urls_blank'

    it 'エラーメッセージが表示される(３つ)' do
      is_expected.to have_css('div.alert-danger', I18n.t('user.summaries.errors.invalid_slack_urls'))
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Contents slack url',
                                                                            message: I18n.t(:'errors.messages.required') }))
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Contents slack url',
                                                                            message: I18n.t(:'errors.messages.invalid') }))
    end
  end

  context 'Slack URLのチャンネルが有効でない' do
    include_context 'create_summary_with_slack_urls_invalid'

    it 'エラーメッセージが表示される(３つ)' do
      is_expected.to have_css('div.alert-danger', I18n.t('user.summaries.errors.channel_invalid_slack_urls', Settings.slack[:permit_channel]))
    end
  end

  context 'Titleが空' do
    include_context 'create_summary_with_summary_title_blank'

    it 'エラーメッセージが表示される(1つ)' do
      is_expected.to have_css('li',               I18n.t('errors.format', { default: '%{attribute} %{message}',
                                                                            attribute: 'Title',
                                                                            message: I18n.t(:'errors.messages.required') }))
    end
  end

end
