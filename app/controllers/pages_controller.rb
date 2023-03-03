class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_listings
    @flats = current_user.flats
  end
end
