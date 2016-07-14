class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Application status
  def server_status
    data = {payload: {service: 'Show Time SF'}, meta: {message: 'Service running!!'}}
    render json: data, status: :ok
  end
end
