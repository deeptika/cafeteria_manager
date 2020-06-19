class Cart < ApplicationRecord
  belongs_to :menu
  belongs_to :menu_item
  belongs_to :user
end
