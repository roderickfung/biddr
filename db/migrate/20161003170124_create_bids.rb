class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.datetime :date
      t.float :price

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
