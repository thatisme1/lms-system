class HomeController < ApplicationController
  before_filter :authenticate_user! ,:only => :secure
  def index
     if user_signed_in?

       render :secure
       else redirect_to new_user_session_path
     end
  end
  def secure

  end
end
