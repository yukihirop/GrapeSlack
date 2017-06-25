class ContentsController < ApplicationController
  before_action :set_summary, only: [:new, :create]
  before_action :build_content, only: :create
  before_action :set_content, only: :destroy
  before_action :you_look_user, only: :index

  include GrapeSlack::SlackUrlProccesable

  def index
    @contents = you_look_user.contents.page(params[:page])
  end

  def new
    @content = @summary.contents.build
    #一旦redisに保存してたキーを削除して再度作成
    SlackMemberJob.perform_later
    SlackChannelListJob.perform_later
  end

  def create
    if remake_contents.map(&:valid?).first && Content.import(remake_contents.map(&:set_attributes))
      redirect_to summaries_path(current_user.nickname), notice: I18n.t('user.contents.messages.create')
    else
      @content = @summary.contents.build(content_params)
      @content.validate
      render :new
    end
  end

  def destroy
    @content.destroy
    flash[:notice] = I18n.t('user.contents.messages.destroy')
    case request.path_info
      when /\/#{current_user.nickname}\/summaries/
        redirect_to summary_path(current_user.nickname, content_params_at_delete[:summary_id])
      when /\/#{current_user.nickname}\/contents/
        redirect_to contents_path(current_user.nickname)
    end
  end

  private

  def content_params
    params.require(:content).permit(
        :slack_url, :id, :summary_id
    )
  end

  def content_params_at_delete
    params.permit(
        :id, :summary_id
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
    @remake_contents = @summary.contents.build(contents_params_after_treatment(txt_slack_urls))
  end

  private
  # こうすることでtypoを防げる。
  attr_accessor :remake_contents


end
