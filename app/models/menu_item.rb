class MenuItem < ApplicationRecord
  belongs_to :menu
  has_many :carts
end
