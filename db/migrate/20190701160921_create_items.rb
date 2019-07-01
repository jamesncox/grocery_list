class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :produce
      t.string :meat
      t.string :fish
      t.string :grains
      t.string :dairy
      t.string :snacks
      t.string :spices
      t.string :staples
      t.string :frozen
      t.integer :user_id
    end 
  end
end
