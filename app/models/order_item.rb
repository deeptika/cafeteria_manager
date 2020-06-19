class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def self.get_items(order_id)
    all.where(order_id: order_id)
  end

  def self.get_total(order_id)
    all.where(order_id: order_id).sum(:total)
  end
end
