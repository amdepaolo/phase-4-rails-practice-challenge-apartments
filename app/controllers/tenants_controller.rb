class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def index
        tenants = Tenant.all 
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, include: :leases
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Apartment.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, include: :leases, status: :accepted
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def render_record_not_found
        render json: {error: "Tenant not found"}, status: :not_found 
    end

    def render_record_invalid
        render json: {error: "Validation error"}, status: :unprocessable_entity
    end
end
