Add a new column type test to the activerecord_model_sqlite3 test app.

The user will specify a column type and column name (e.g. "boolean型の published カラム").
If not specified, ask the user for: (1) column type, (2) column name, (3) fixture value (primary), (4) fixture value 2 (a different value for mutation tests).

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

## 6. sig/app.rbs に save! を確認・追加

`siggen/test/activerecord_model_sqlite3/sig/app.rbs` の `ActiveRecord::Base` クラスに
`def save!: (**untyped options) -> bool` が存在することを確認する。
なければ追加する。

```rbs
module ActiveRecord
  class Base
    def self.first: () -> instance?
    def self.first!: () -> instance
    def save!: (**untyped options) -> bool
  end
end
```

## 7. テストを追加

`siggen/test/activerecord_model_sqlite3/test/models/post_test.rb` に以下を追加する。
`<カラム名>`・`<型名>`・`<Ruby型>`・`<フィクスチャ値>`・`<フィクスチャ値2>` を実際の値に置き換えること。
`<フィクスチャ値2>` はフィクスチャ値と**異なる**値を使う（変更前後を区別するため）。

```ruby
# --- getter / setter ---

test "<型名> column <カラム名> is typed as <Ruby型>" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>
end

test "<型名> column <カラム名>= sets a new <Ruby型> value" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert_equal <フィクスチャ値2>, post.<カラム名>
end

# --- BeforeTypeCast / ForDatabase ---

test "<型名> column <カラム名>_before_type_cast returns untyped" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>_before_type_cast
end

test "<型名> column <カラム名>_for_database returns untyped" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>_for_database
end

# --- came_from_user? / query method ---

test "<型名> column <カラム名>_came_from_user? returns false for DB-loaded record" do
  post = Post.first!
  assert_equal false, post.<カラム名>_came_from_user?
end

test "<型名> column <カラム名>? returns bool" do
  post = Post.first!
  assert post.<カラム名>?
end

# --- Dirty tracking: in-memory change ---

test "<型名> column <カラム名>_changed? returns false before change" do
  post = Post.first!
  assert_equal false, post.<カラム名>_changed?
end

test "<型名> column <カラム名>_changed? returns true after assignment" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert post.<カラム名>_changed?
end

test "<型名> column <カラム名>_change returns nil before change" do
  post = Post.first!
  assert_nil post.<カラム名>_change
end

test "<型名> column <カラム名>_change returns [old, new] after assignment" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert_equal [<フィクスチャ値>, <フィクスチャ値2>], post.<カラム名>_change
end

test "<型名> column <カラム名>_will_change! marks attribute as changed" do
  post = Post.first!
  post.<カラム名>_will_change!
  assert post.<カラム名>_changed?
end

test "<型名> column <カラム名>_was returns original value before change" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>_was
end

test "<型名> column <カラム名>_was returns old value after assignment" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert_equal <フィクスチャ値>, post.<カラム名>_was
end

test "<型名> column restore_<カラム名>! restores the original value" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.restore_<カラム名>!
  assert_equal <フィクスチャ値>, post.<カラム名>
  assert_equal false, post.<カラム名>_changed?
end

test "<型名> column clear_<カラム名>_change clears dirty state" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.clear_<カラム名>_change
  assert_equal false, post.<カラム名>_changed?
end

test "<型名> column will_save_change_to_<カラム名>? returns false before change" do
  post = Post.first!
  assert_equal false, post.will_save_change_to_<カラム名>?
end

test "<型名> column will_save_change_to_<カラム名>? returns true after assignment" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert post.will_save_change_to_<カラム名>?
end

test "<型名> column <カラム名>_change_to_be_saved returns nil before change" do
  post = Post.first!
  assert_nil post.<カラム名>_change_to_be_saved
end

test "<型名> column <カラム名>_change_to_be_saved returns pending change after assignment" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  assert_equal [<フィクスチャ値>, <フィクスチャ値2>], post.<カラム名>_change_to_be_saved
end

test "<型名> column <カラム名>_in_database returns the DB value" do
  post = Post.first!
  assert_equal <フィクスチャ値>, post.<カラム名>_in_database
end

# --- Dirty tracking: after save ---

test "<型名> column <カラム名>_previously_changed? returns true after save with change" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert post.<カラム名>_previously_changed?
end

test "<型名> column <カラム名>_previous_change returns [old, new] after save" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert_equal [<フィクスチャ値>, <フィクスチャ値2>], post.<カラム名>_previous_change
end

test "<型名> column <カラム名>_previously_was returns old value after save" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert_equal <フィクスチャ値>, post.<カラム名>_previously_was
end

test "<型名> column saved_change_to_<カラム名>? returns false without save" do
  post = Post.first!
  assert_equal false, post.saved_change_to_<カラム名>?
end

test "<型名> column saved_change_to_<カラム名>? returns true after save with change" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert post.saved_change_to_<カラム名>?
end

test "<型名> column saved_change_to_<カラム名> returns nil without save" do
  post = Post.first!
  assert_nil post.saved_change_to_<カラム名>
end

test "<型名> column saved_change_to_<カラム名> returns [old, new] after save" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert_equal [<フィクスチャ値>, <フィクスチャ値2>], post.saved_change_to_<カラム名>
end

test "<型名> column <カラム名>_before_last_save returns old value after save" do
  post = Post.first!
  post.<カラム名> = <フィクスチャ値2>
  post.save!
  assert_equal <フィクスチャ値>, post.<カラム名>_before_last_save
end
```

## 8. テストを実行して確認

```bash
cd siggen/test/activerecord_model_sqlite3
bundle exec rake
```

テスト・Steep 型チェック両方パスすることを確認する。

## 9. コミット

以下のファイルをすべてステージしてコミットする:
- `siggen/test/activerecord_model_sqlite3/db/schema.rb`
- `siggen/test/activerecord_model_sqlite3/db/migrate/<timestamp>_add_<col>_to_posts.rb`
- `siggen/test/activerecord_model_sqlite3/sig/app.rbs`
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
- `boolean` 型では `<カラム名>?` クエリメソッドのテストを `assert post.<カラム名>?` にするか
  フィクスチャ値に応じて `assert_equal false, post.<カラム名>?` に変更すること。
- `<フィクスチャ値2>` は `before_type_cast` / `for_database` のテストでは使用しない
  （変更前の値のみ検証する）。
