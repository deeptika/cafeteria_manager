class Menu < ApplicationRecord
  validates :menu_name, presence: true
  has_many :menu_items
  has_many :carts
end
