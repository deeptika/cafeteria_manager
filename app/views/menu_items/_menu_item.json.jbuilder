json.extract! menu_item, :id, :menu_id, :menu_item_name, :menu_item_price, :created_at, :updated_at
json.url menu_item_url(menu_item, format: :json)
