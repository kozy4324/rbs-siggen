class AddPriceToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :price, :decimal
  end
end
