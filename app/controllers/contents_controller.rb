class ContentsController < ApplicationController
  before_action :build_content, only: :create
  before_action :set_summary, only: [:new, :create]
  before_action :set_content, only: :destroy

  def index
    @contents = Content.all
  end

  def new
    @content = @summary.contents.build
  end

  def create

    if @content.save
      redirect_to summaries_path, notice: I18n.t('user.contents.messages.create')
    end
  end

  def destroy
    @content.destroy
    redirect_to contents_path, notice: I18n.t('user.contents.messages.destroy')
  end

  private

  def content_params
    params.require(:content).permit(:slack_url, :content_id)
  end

  def build_content
    @content = current_user.summaries.find(params[:summary_id]).contents.build(content_params)
  end

  def set_summary
    @summary = current_user.summaries.find(params[:summary_id])
  end

  def set_content
    @content = Content.find(content_params)
  end

end
