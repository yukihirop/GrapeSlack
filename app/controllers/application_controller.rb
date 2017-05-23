class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_request

  def set_request
    Thead.current[:request] = request
  end

end
