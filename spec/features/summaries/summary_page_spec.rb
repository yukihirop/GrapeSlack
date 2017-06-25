require 'rails_helper'

describe 'Summariesページ', type: :feature, vcr: { cassette_name: 'create_summary' } do
  include_context 'create_summary'

  subject { page }

  #TODO: まだ実装出来ていない
  describe '新規作成' do
    it 'ページのタイトルとまとめ作成ボタンの確認' do
      is_expected.to have_content(I18n.t('user.contents.title'))
      is_expected.to have_css('a', I18n.t('user.summaries.forms.create'))
    end

    it '作成されたまとめの確認' do
      is_expected.to have_css('a', summary_title)
      is_expected.to have_content('2')
      is_expected.to have_css('a', I18n.t('commons.add'))
      is_expected.to have_css('a', I18n.t('commons.delete'))
    end

    it '作成のメッセージが表示される' do
      is_expected.to have_css('div.alert-success', I18n.t('user.summaries.messages.create'))
    end
  end

  describe '作成したまとめの閲覧' do
    let(:test_message_1) { 'GrapeSlackのRSpecのテスト' }
    let(:test_message_2) { '@slackbot GrapeSlackのRSpecのテスト2' }

    before do
      click_link summary_title
    end

    it '2件の投稿が入っている' do
      is_expected.to have_css('p', test_message_1)
      is_expected.to have_css('p', test_message_2)
      is_expected.to have_css('a', I18n.t('commons.delete'))
    end
  end

  describe 'まとめの削除' do
    before do
      click_link I18n.t('commons.delete')
    end

    it '1件のまとめが削除される' do
      is_expected.to have_css('div.alert-success', I18n.t('user.summaries.messages.destroy'))
    end
  end

  describe '投稿の削除' do
    let(:test_message_1) { 'GrapeSlackのRSpecのテスト' }
    let(:test_message_2) { '@slackbot GrapeSlackのRSpecのテスト2' }

    before do
      click_link summary_title
      click_link I18n.t('commons.delete'), match: :first
    end

    it '1件の投稿が削除される' do
      expect(page.all("ul[class='list-unstyled']").size).to eq(1)
      is_expected.to have_css('p', test_message_2)
    end
  end

end

# [参考] http://kazuooooo.hatenablog.com/entry/2015/12/05/225708
describe 'Summariesページ', type: :feature, vcr: { cassette_name: 'add_content', record: :new_episodes } do
  include_context 'add_summary_content'

  subject { page }

  describe '作成したまとめに投稿を追加' do
    let(:test_message_3) { '@slackbot GrapeSlackのRSpecの追加テスト' }

    it '作成されたメッセージが表示される' do
      is_expected.to have_css('div.alert-success', text: I18n.t('user.contents.messages.create'))
    end
  end

  describe '追加されたまとめを確認する' do
    let(:test_message_1) { 'GrapeSlackのRSpecのテスト' }
    let(:test_message_2) { '@slackbot GrapeSlackのRSpecのテスト2' }
    let(:test_message_3) { '@slackbot GrapeSlackのRSpecの追加テスト' }

    before do
      click_link summary_title
    end

    it '追加した投稿が確認できること' do
      is_expected.to have_css('p', test_message_1)
      is_expected.to have_css('p', test_message_2)
      is_expected.to have_css('p', test_message_3)
    end
  end
end

