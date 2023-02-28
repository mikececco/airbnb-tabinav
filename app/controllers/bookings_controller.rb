class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  # show: will display the details of a specific booking, such as the price and location
  def show
    @booking = Booking.find(params[:id])
  end

  # new: will display a form to create a new booking
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:price, :address, :city, :booking_location, :photo)
  end
end
