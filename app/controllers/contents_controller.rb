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
    if multi_contents_save
      redirect_to summaries_path, notice: I18n.t('user.contents.messages.create')
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
        :slack_url, :content_id, :summary_id
    )
  end


  def set_summary
    @summary = current_user.summaries.find(params[:summary_id])
  end

  def set_content
    #TODO: content_paramsで通すように書き直す
    @content = Content.find(params[:id])
  end

  #contets#createのサブルーチン
  def current_summary
    current_user.summaries.find(params[:summary_id])
  end

  def build_content
    @content = current_summary.contents.build(content_params)
    @content.params = content_params
  end

  def remake_contents
    @remake_contents ||= @content.remake_multi_records
  end


  def multi_contents_save
    @contents = []
    remake_contents.each do |content|
      @contents << current_summary.contents.build(content)
    end
    Content.import @contents
  end

end
