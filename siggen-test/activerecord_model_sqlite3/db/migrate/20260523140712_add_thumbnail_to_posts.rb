class AddThumbnailToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :thumbnail, :binary
  end
end
