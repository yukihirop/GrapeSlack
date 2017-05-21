class ContentsController < ApplicationController
  before_action :build_content, only: :create
  before_action :set_summary, only: [:new, :create]

  def new
    @content = @summary.contents.build
  end

  def create
    if @content.save
      redirect_to summaries_path, notice: 'Content was successfully created.'
    end
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

end
