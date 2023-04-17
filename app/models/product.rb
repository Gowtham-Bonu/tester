class Product < ApplicationRecord
  belongs_to :user

  validates :product_name, :price, presence: true
  validates :price, numericality: true
end
