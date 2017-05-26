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
    if multi_contents_save
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
    #TODO: summary_paramsで通すように書き直す
    @summary = Summary.find(params[:id])
  end

  def summary_params
    params.require(:summary).permit(
        :title, :user_id,
        contents_attributes:[:id,:slack_url]
    )
  end

  # summaries#createのサブルーチン
  def build_summary
    @summary = current_user.summaries.build(summary_params)
    @summary.contents.last.params = summary_params['contents_attributes']['0']
  end

  def summary_content
    @summary_content ||= @summary.contents.last
  end

  def remake_contents
    @remake_contents = summary_content.remake_multi_records
  end

  def first_save_summary_content
    @merged_summary = summary_params.merge('contents_attributes' => {'0' => remake_contents[0]})
    @first_save_summary_content ||= current_user.summaries.build(@merged_summary)
  end

  def summary_contents_index(n)
    @summary_content_index ||= remake_contents[n]
  end

  def multi_contents_save
    @contents = []
    if first_save_summary_content.save
      # 最初は保存したのでdropで除去
      remake_contents.drop(1).each do |content|
        @contents << first_save_summary_content.contents.build(content)
      end
      Content.import @contents
    end
  end

end
