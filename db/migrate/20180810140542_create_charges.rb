class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :amount
      t.string :stripe_id
      t.string :card_last4
      t.string :card_brand
      t.string :card_exp_month
      t.string :card_exp_year
      t.datetime :charge_date

      t.timestamps
    end

    add_index :charges, :stripe_id, unique: true
  end
end
