class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_brand

  def set_brand
    if current_user && current_user.village
      @brand_title = "#{current_user.village.title}.online"
    else
      @brand_title = "MyVillage.online"
    end
  end

end
