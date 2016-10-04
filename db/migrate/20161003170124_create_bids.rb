class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.float :price

      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
