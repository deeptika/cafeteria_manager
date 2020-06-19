class MenuItem < ApplicationRecord
  validates :menu_item_name, presence: true
  validates :menu_item_price, presence: true
  validates :stock, presence: true
  belongs_to :menu
  has_many :carts
end
