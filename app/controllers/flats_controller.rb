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
    @flat = Flat.new
  end

  # show: will display the details of a specific flat, such as the price and location
  def show
    @flat = Flat.find(params[:id])
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

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
    @flat.update(flat_params)
    redirect_to flat_path(@flat)
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to flats_path, status: :see_other
  end

  private

  def flat_params
    params.require(:flat).permit(:price, :address, :city, :flat_location, :photo)
  end

  # create: will receive the form data submitted through the new action and create a new flat in the database
end
