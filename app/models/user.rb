class User < ApplicationRecord
  validates :first_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :orders
  has_many :carts

  def is_customer(user_id)
    User.find(user_id).role == "customer"
  end

  def is_owner(user_id)
    User.find(user_id).role == "owner"
  end

  def is_clerk(user_id)
    User.find(user_id).role == "clerk"
  end
end
