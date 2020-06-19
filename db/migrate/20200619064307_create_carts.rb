class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.bigint :user_id
      t.bigint :menu_item_id
      t.integer :quantity
      t.bigint :menu_id

      t.timestamps
    end
  end
end
