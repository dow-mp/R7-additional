class Order < ApplicationRecord
  belongs_to :customer

  validates :product_name, presence: true
  validates :product_count, presence: true, numericality: { only_integer: true }
  validates_associated :customer
end
