class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Exception,                        with: :render_500
  rescue_from ActiveRecord::RecordNotFound,     with: :render_404
  rescue_from ActionController::RoutingError,   with: :render_404


  # [参考] http://qiita.com/suzuki_koya/items/b2a7039b08917e2171df
  def routing_error
    raise ActionController::RoutingError,
          "No route matches #{request.path.inspect}"
  end

  def render_500(e=nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e
    render json: {error: '500 error'}, status:500
  end

  def render_404(e=nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    render json: {error: '404 error'}, status:404
  end

end
