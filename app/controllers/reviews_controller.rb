class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    authorize(@review)
    @booking = Booking.find(params[:booking_id])
  end

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @flat = Flat.find(@booking.flat.id)
    @review.booking = @booking
    authorize(@review)
    if @review.save
      redirect_to flat_path(@booking.flat), notice: "Review created successfully!"
    else
      render 'bookings/show', status: :unprocessable_entity, flat: @flat, alert: "Failed to create review"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :description)
  end
end
