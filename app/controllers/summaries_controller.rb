class SummariesController < ApplicationController
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
      @summary = Summary.new(summary_params)
      @summary.validate
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
    #TODO: summary_paramsで通すように書き直す
    @summary = Summary.find(params[:id])
  end

  def only_summary_params
    params.require(:summary).permit(
                                :title, :user_id
    )
  end

  def summary_params
    params.require(:summary).permit(
        :title, :user_id,
        contents_attributes:[:slack_url]
    )
  end

  def build_summary
    @summary = current_user.summaries.build(only_summary_params)
    txt_slack_urls = summary_params['contents_attributes']['0']['slack_url']
    remake_contents_params = GrapeSlack::URLParser.new(txt_slack_urls).remake_contents_params
    @summary.contents.build(remake_contents_params)
  end

end
