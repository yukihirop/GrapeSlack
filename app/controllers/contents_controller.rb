class ContentsController < ApplicationController
  before_action :build_content, only: :create

  def create



  end

  def summary_params
    params.require(:summary).permit(:slack_url, :content_id)
  end

  private

  def build_content
    @content = @summary.build(content_params)
  end

end
