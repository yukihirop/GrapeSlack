class ContentsController < ApplicationController
  before_action :set_summary, only: [:new, :create]
  before_action :build_content, only: :create
  before_action :set_content, only: :destroy

  def index
    @contents = Content.all
  end

  def new
    @content = @summary.contents.build
    #一旦redisに保存してたキーを削除して再度作成
    SlackMemberJob.perform_later(true)
    SlackChannelListJob.perform_later(true)
  end

  def create
    if remake_contents.map(&:valid?).first && Content.import(remake_contents.map(&:set_attributes))
      redirect_to summaries_path, notice: I18n.t('user.contents.messages.create')
    else
      @content = remake_contents.first
      render :new
    end
  end

  def destroy
    @content.destroy
    flash[:notice] = I18n.t('user.contents.messages.destroy')
    case request.path_info
      when /\/user\/summaries/
        redirect_to summary_path(params[:summary_id])
      when /\/user\/contents/
       redirect_to contents_path
    end
  end

  private

  def content_params
    params.require(:content).permit(
        :slack_url, :id, :summary_id
    )
  end


  def set_summary
    @summary = current_user.summaries.find(params[:summary_id])
  end

  def set_content
    #TODO: content_paramsで通すように書き直す
    @content = Content.find(params[:id])
  end

  def build_content
    txt_slack_urls = content_params['slack_url']
    remake_contents_params = GrapeSlack::URLParser.new(txt_slack_urls).remake_contents_params
    @remake_contents = @summary.contents.build(remake_contents_params)
  end

  private
  # こうすることでtypoを防げる。
  attr_accessor :remake_contents


end
