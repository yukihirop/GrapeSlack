shared_context 'execute_add_summary_content' do
  include_context 'create_summary'
  before do
    click_link I18n.t('commons.add'), match: :first
    #意図的に呼び出す必要がある。
    perform_enqueued_jobs do
      SlackMemberJob.perform_later
      SlackChannelListJob.perform_later
    end
    fill_in 'content_slack_url', with: add_slack_urls
    click_button I18n.t('helpers.submit.create')
  end
end

shared_context 'add_summary_content' do
  let(:add_slack_urls) do
    <<~EOS
    https://aiming.slack.com/archives/C5GACEUP6/p1497760547738909
    EOS
  end
  include_context 'execute_add_summary_content'
end

shared_context 'add_summary_content_with_slack_urls_blank' do
  let(:add_slack_urls) { ' ' }
  include_context 'execute_add_summary_content'
end

shared_context 'add_summary_content_with_slack_urls_invalid' do
  let(:add_slack_urls) do
    <<~EOS
    https://aiming.slack.com/archives/C0GACEUP6/p1497760547738909
    EOS
  end
  include_context 'execute_add_summary_content'
end
