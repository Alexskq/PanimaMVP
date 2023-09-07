class ProfilsController < ApplicationController
  def theme
    user = current_user
    user.dark_mode = !user.dark_mode
    user.save
  end
end
