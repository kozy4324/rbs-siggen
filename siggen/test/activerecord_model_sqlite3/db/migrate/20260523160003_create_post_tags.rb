class CreatePostTags < ActiveRecord::Migration[8.1]
  def change
    create_table "post_tags", id: false do |t|
      t.integer "post_id", null: false
      t.string "tag_name", null: false
    end
  end
end
