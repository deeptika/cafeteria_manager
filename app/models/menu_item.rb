class MenuItem < ApplicationRecord
  validates :menu_item_name, presence: true
  validates :menu_item_price, presence: true
  belongs_to :menu
  has_many :carts

  def self.current_menu(menu_id)
    all.where(menu_id: menu_id)
  end
end
