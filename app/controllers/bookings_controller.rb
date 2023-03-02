class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update]

  def index
    @bookings = current_user.bookings
  end

  # show: will display the details of a specific booking, such as the price and location
  def show
    authorize @booking
    @flat = @booking.flat
    # @booking = Booking.find(params[:id])
    # @flat = Flat.find(@booking.flat.id)
    @review = Review.new
  end

  # new: will display a form to create a new booking
  def new
    @booking = Booking.new
    @flat = Flat.find(params[:flat_id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = Flat.find(params[:flat_id])
    @booking.flat = @flat
    @booking.user = current_user
    authorize @booking


    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking confirmed"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      redirect_to bookings_path(@booking), notice: "Booking edited added"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    # No need for app/views/restaurants/destroy.html.erb
    # redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
