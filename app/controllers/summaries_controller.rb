class SummariesController < ApplicationController
  before_action :exit_current_user?
  before_action :set_summary, only: [:show, :edit, :update, :destroy]
  before_action :build_summary, only: :create

  def index
    @summaries = current_user.summaries
  end

  def show
    @contents = @summary.contents
  end

  def new
    @summary = Summary.new
    @summary.contents.build
  end

  def create
    if @summary.save
      redirect_to summaries_path, notice: I18n.t('user.summaries.messages.create')
    else
      render :new
    end
  end

  def update
    if @summary.update(summary_params)
      redirect_to @summary, notice: I18n.t('user.summaries.messages.update')
    else
      render :edit
    end
  end

  def destroy
    @summary.destroy
    redirect_to summaries_url, notice: I18n.t('user.summaries.messages.destroy')
  end

  private
  def set_summary
    @summary = Summary.find(params[:id])
  end

  def summary_params
    params.require(:summary).permit(
        :title, :user_id,
        contents_attributes:[:id,:slack_url]
    )
  end

  def build_summary
    @summary = current_user.summaries.build(summary_params)
  end

end
