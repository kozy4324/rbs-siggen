class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table "articles", id: :string do |t|
      t.string "name"
    end
  end
end
