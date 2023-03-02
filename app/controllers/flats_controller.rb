class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  # index: will display a list of all the available flats
  def index
    @query = params[:search].nil? ? "" : params[:search]
    if @query == ""
      @flats = Flat.all
    else
      @flats = Flat.where("lower(city) LIKE ? OR lower(flat_location) LIKE ?", @query.downcase + "%", @query.downcase + "%")
    end

    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat})
      }
    end
  end

  # show: will display the details of a specific flat, such as the price and location
  def show
    @flat = Flat.find(params[:id])
    @booking = @flat.bookings.find_by(user_id: current_user.id)
  end

  # new: will display a form to create a new flat
  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:price, :address, :city, :flat_location, :photo)
  end

  # create: will receive the form data submitted through the new action and create a new flat in the database
end
