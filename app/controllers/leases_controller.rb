class LeasesController < ApplicationController

    def create
        lease = Lease.create(params.permit(:rent, :apartment_id, :tenant_id))
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: {error: "No such lease"}, status: :not_found
    end
end
