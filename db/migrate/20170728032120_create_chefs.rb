class CreateChefs < ActiveRecord::Migration[5.1]
  def change
    create_table :chefs do |t|

      t.string :chetname
      t.string :email
      t.timestamps
    end
  end
end
