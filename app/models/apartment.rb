class Apartment < ApplicationRecord
    validates :number, uniqueness: true
    has_many :leases, dependent: :destroy
    has_many :tenants, through: :leases
end
