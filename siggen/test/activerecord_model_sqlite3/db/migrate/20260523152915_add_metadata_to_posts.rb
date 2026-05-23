class AddMetadataToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :metadata, :json
  end
end
