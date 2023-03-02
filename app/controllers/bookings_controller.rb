class BookingsController < ApplicationController
  def index
    if current_user.role == "renter"
      @bookings = Booking.where("user = current_user")
    else
      @bookings = Booking.joins(:flat).where(params[:user_id] == current_user.id)
    end
  end

  # show: will display the details of a specific booking, such as the price and location
  def show
    @booking = Booking.find(params[:id])
    @flat = @booking.flat
  end

  # new: will display a form to create a new booking
  def new
    @booking = Booking.new
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @flat = Flat.find(params[:flat_id])
    @booking.flat = @flat
    @booking.user = current_user

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
end
