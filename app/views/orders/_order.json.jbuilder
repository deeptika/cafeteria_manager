json.extract! order, :id, :user_id, :date, :delivered_at, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
