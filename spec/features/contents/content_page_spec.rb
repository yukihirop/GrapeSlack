require 'rails_helper'

describe 'Contentsページ', type: :feature, vcr: { cassette_name: 'create_summary' } do
  include_context 'create_summary'

  before do
    click_link I18n.t('user.contents.title')
  end

  subject { page }

  describe '作成したまとめの閲覧' do
    let(:test_message_1)    { 'GrapeSlackのRSpecのテスト' }
    let(:test_message_2)    { '@slackbot GrapeSlackのRSpecのテスト2' }

    it '2件の投稿が入っている' do
      is_expected.to have_css('p', test_message_1)
      is_expected.to have_css('p', test_message_2)
      is_expected.to have_css('a', I18n.t('commons.delete'))
    end
  end

  describe '投稿の削除' do
    let(:test_message_1)    { 'GrapeSlackのRSpecのテスト' }
    let(:test_message_2)    { '@slackbot GrapeSlackのRSpecのテスト2' }

    before do
      click_link I18n.t('commons.delete'), match: :first
    end

    it '1件の投稿が削除される' do
      expect(page.all("ul[class='list-unstyled']").size).to eq(1)
      is_expected.to have_css('p', test_message_2)
    end

    it '削除のメッセージが表示される' do
      is_expected.to have_css('div.alert-success', I18n.t('user.contents.messages.destroy'))
    end
  end
end
