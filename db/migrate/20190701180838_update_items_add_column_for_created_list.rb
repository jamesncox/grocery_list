class UpdateItemsAddColumnForCreatedList < ActiveRecord::Migration
  def change
    add_column :items, :shopping_day, :string
  end
end
