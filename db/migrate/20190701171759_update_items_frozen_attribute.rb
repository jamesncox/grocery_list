class UpdateItemsFrozenAttribute < ActiveRecord::Migration
  def change
    rename_column :items, :frozen, :freezer 
  end
end
