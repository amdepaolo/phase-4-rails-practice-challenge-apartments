class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def index
        apartments = Apartment.all 
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, include: :leases
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, include: :leases, status: :accepted
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def render_record_not_found
        render json: {error: "Apartment not found"}, status: :not_found 
    end

    def render_record_invalid
        render json: {error: "Validation error"}, status: :unprocessable_entity
    end
end
