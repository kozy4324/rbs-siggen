Add a new column type test to the activerecord_model_sqlite3 test app.

The user will specify a column type and column name (e.g. "boolean型の published カラム").
If not specified, ask the user for: (1) column type, (2) column name, (3) fixture value.

Follow these steps in order:

## 1. schema.rb にカラムを追加

`siggen/test/activerecord_model_sqlite3/db/schema.rb` の `create_table "posts"` ブロックに
`t.<型名> "<カラム名>"` を追加する（アルファベット順で挿入）。

## 2. マイグレーションファイルを作成

`siggen/test/activerecord_model_sqlite3/db/migrate/<timestamp>_add_<col>_to_posts.rb` を作成。
timestamp は `date +%Y%m%d%H%M%S` で生成する。

```ruby
class Add<ColCamel>ToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :<col>, :<type>
  end
end
```

## 3. マイグレーションを実行

```bash
cd siggen/test/activerecord_model_sqlite3
bundle exec rails db:migrate RAILS_ENV=test
```

## 4. フィクスチャを更新

`siggen/test/activerecord_model_sqlite3/test/fixtures/posts.yml` の `one:` と `two:` 両方に
`<カラム名>: <フィクスチャ値>` を追加する（両レコード同じ値にする）。

## 5. sig/siggen.rbs を再生成

```bash
cd siggen/test/activerecord_model_sqlite3
BUNDLE_GEMFILE=../../../Gemfile bundle exec ../../../exe/rbs-siggen --rails > sig/siggen.rbs
```

生成後、対象カラムのメソッド（`def <col>: () -> <RBS型>` など）が含まれていることを確認する。

## 6. テストを追加

`siggen/test/activerecord_model_sqlite3/test/models/post_test.rb` に以下を追加:

```ruby
test "<型名> column <カラム名> is typed as <Ruby型>" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>
end
```

## 7. テストを実行して確認

```bash
cd siggen/test/activerecord_model_sqlite3
bundle exec rails test
bundle exec steep check
```

両方パスすることを確認する。

## 8. コミット

以下のファイルをすべてステージしてコミットする:
- `siggen/test/activerecord_model_sqlite3/db/schema.rb`
- `siggen/test/activerecord_model_sqlite3/db/migrate/<timestamp>_add_<col>_to_posts.rb`
- `siggen/test/activerecord_model_sqlite3/sig/siggen.rbs`
- `siggen/test/activerecord_model_sqlite3/test/fixtures/posts.yml`
- `siggen/test/activerecord_model_sqlite3/test/models/post_test.rb`

コミットメッセージ例:
```
Add <型名> column test for <カラム名>
```

## 注意事項

- `activerecord_model.rbs.erb` にカラム型が存在しない場合は先にマッピングを追加し、
  プロジェクトルートで `bundle exec rake run_erb` を実行して `activerecord_model.rbs` を再生成する。
- カラム型と生成される RBS 型の対応は `siggen/README.md` のテーブルを参照。
- `null: false` を付けると非 nullable（`?` なし）、付けなければ nullable（`::型?`）になる。
