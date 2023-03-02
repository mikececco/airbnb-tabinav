class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]

  def index
    @bookings = Booking.where(params[:user_id] == current_user)
  end

  # show: will display the details of a specific booking, such as the price and location
  def show
    @flat = @booking.flat
    authorize(@booking)
  end

  # new: will display a form to create a new booking
  def new
    @booking = Booking.new
    @flat = Flat.find(params[:flat_id])
    authorize(@booking)
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = Flat.find(params[:flat_id])
    @booking.flat = @flat
    @booking.user = current_user
    authorize(@booking)


    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
