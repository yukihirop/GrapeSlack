shared_context 'execute_create_summary' do
  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    click_link I18n.t('user.summaries.title')
    click_link I18n.t('user.summaries.tables.create')
    #意図的に呼び出す必要がある。
    perform_enqueued_jobs do
      SlackMemberJob.perform_later
      SlackChannelListJob.perform_later
    end
    fill_in 'summary_title',                           with: summary_title
    fill_in 'summary_contents_attributes_0_slack_url', with: slack_urls
    click_button I18n.t('helpers.submit.create')
  end
end

shared_context 'create_summary' do
  let(:summary_title) { 'Test Title' }
  let(:slack_urls) do
    <<~EOS
    https://aiming.slack.com/archives/C5GACEUP6/p1497709185259591
    https://aiming.slack.com/archives/C5GACEUP6/p1497709263264251
    https://aiming.slack.com/archives/C0GACEUP6/p1497709263264251
    EOS
  end
  include_context 'execute_create_summary'
end

shared_context 'create_summary_with_blank' do
  let(:summary_title) { ' ' }
  let(:slack_urls)    { ' ' }
  include_context 'execute_create_summary'
end

shared_context 'create_summary_with_summary_title_blank' do
  let(:summary_title) { ' ' }
  let(:slack_urls) do
    <<~EOS
    https://aiming.slack.com/archives/C5GACEUP6/p1497709185259591
    https://aiming.slack.com/archives/C5GACEUP6/p1497709263264251
    https://aiming.slack.com/archives/C0GACEUP6/p1497709263264251
    EOS
  end
  include_context 'execute_create_summary'
end

shared_context 'create_summary_with_slack_urls_blank' do
  let(:summary_title) { 'Test Title' }
  let(:slack_urls)    { ' '          }
  include_context 'execute_create_summary'
end

shared_context 'create_summary_with_slack_urls_invalid' do
  let(:summary_title) { ' ' }
  let(:slack_urls) do
    <<~EOS
    https://aiming.slack.com/archives/C0GACEUP6/p1497709185259591
    https://aiming.slack.com/archives/C0GACEUP6/p1497709263264251
    https://aiming.slack.com/archives/C0GACEUP6/p1497709263264251
    EOS
  end
  include_context 'execute_create_summary'
end
