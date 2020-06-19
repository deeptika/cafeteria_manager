class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.pending_order
    all.where(delivered_at: nil)
  end

  def self.get_report(from, to, user)
    if user != ""
      if user.to_i != 0
        return Order.where("date > ? and date < ? and user_id = ? ", from, to, user)
      else
        if (User.find_by(first_name: user))
          user = User.where(first_name: user).map { |user| user.id }
        else
          user = 0
        end
        return Order.where("date > ? and date < ? and user_id in (?) ", from, to, user)
      end
    end
    Order.where("date > ? and date < ? ", from, to)
  end

  def self.get_details(order_id)
    user_data = {}
    user_data["name"] = Order.find(order_id).user.first_name
    user_data["date"] = Order.find(order_id).date.to_date
    user_data["email"] = Order.find(order_id).user.email
    user_data
  end
end
