class Menu < ApplicationRecord
  has_many :menu_items
  has_many :carts
end
