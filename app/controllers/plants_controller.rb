class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_error
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  # rescue ActiveRecord::RecordNotFound 
  #   render_error
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # UPDATE /plants/:id

  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  # rescue ActiveRecord::RecordNotFound 
  #   render_error
  end

  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
    # rescue ActiveRecord::RecordNotFound
    #   render_error
  end

  private

  def find_plant
    Plant.find(params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def render_error
    render json: { message: "plant not found" }
  end
end
