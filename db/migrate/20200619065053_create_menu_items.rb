class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.bigint :menu_id
      t.string :menu_item_name
      t.float :menu_item_price

      t.timestamps
    end
  end
end
