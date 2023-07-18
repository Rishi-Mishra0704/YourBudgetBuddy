class SplashController < ApplicationController
  def index
    return unless user_signed_in?

    redirect_to group_index_path
  end
end
