class AddAuthorIdToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :author, null: true, foreign_key: true
  end
end
