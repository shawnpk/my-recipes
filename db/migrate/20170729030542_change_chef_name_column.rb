class ChangeChefNameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :chefs, :chetname, :chefname
  end
end
