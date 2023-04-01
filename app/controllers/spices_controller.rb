class SpicesController < ApplicationController

def index
    spices = Spice.all
    render json: spices
end

def show
    spices = find_spice
    render json: spices
end

def create
    spices = Spice.create(spice_params)
    render json: spices, status: :created
end

def update
    spices = find_spice
    if spices
        spices.update(spice_params)
        render json: spices
    else
        render json: { error: "Spice not found"}, status: :not_found
    end
end

def destroy
    spices = find_spice
    if spices
        spices.destroy
        head :no_content
    else
        render json: { error: "Spice not found"}, status: :not_found
    end
end

private

def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
end

def render_not_found_response
    render json: {error: "Spice not found"}, status: :not_found
end

def find_spice
    Spice.find(params[:id])
rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new('Not Found')
end

end
