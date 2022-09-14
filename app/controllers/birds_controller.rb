class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  def create
    # create! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
    bird = Bird.create!(bird_params)
    render json: bird, status: :created
  end
  
  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = find_bird
    # update! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
    bird.update!(bird_params)
    render json: bird
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content
  end

  private

  def find_bird
    Bird.find(params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def render_not_found_response
    render json: { error: "Bird not found" }, status: :not_found
  end

end
