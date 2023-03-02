class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    @booking = Booking.find(params[:booking_id])
  end

  def create
    @review = Review.new(review_params)
    @booking = Booking.find(params[:booking_id])
    @flat = Flat.find(@booking.flat.id)
    @review.booking = @booking
    if @review.save
      flash[:success] = "Review created successfully!"
      redirect_to flat_path(@booking.flat)
    else
      flash[:error] = "Failed to create review"
      render 'bookings/show', status: :unprocessable_entity, flat: @flat
    end
  end

  # def create
  #   @booking = Booking.find(params[:booking_id])
  #   @review = @booking.reviews.build(review_params)

  #   if @review.save
  #     flash[:success] = "Review created successfully!"
  #     redirect_to flat_path(@booking.flat)
  #   else
  #     flash[:error] = "Failed to create review"
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :description)
  end
end
