class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :current_price
      t.float :reserve_price
      t.date :end_date
      t.string :aasm_state

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
