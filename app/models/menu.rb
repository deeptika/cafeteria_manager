class Menu < ApplicationRecord
  validates :menu_name, presence: true
  has_many :menu_items
  has_many :carts

  def self.active
    if Menu.find_by(active: true)
      Menu.find_by(active: true).id
    end
  end
end
