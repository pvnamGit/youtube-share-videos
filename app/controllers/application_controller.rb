class ApplicationController < ActionController::Base

  helper_method :current_user

  # configuration for Yt gem
  # Yt.configure do |config|
  #   config.api_key = ENV['YOUTUBE_API_KEY']
  #   config.log_level = :debug
  # end

  private
  def authenticate_user!
    unless current_user
      redirect_to sessions_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

end
