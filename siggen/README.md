# siggen/

このディレクトリは **rbs-siggen の Rails/ActiveRecord 向け RBS 生成** に関する作業領域です。

rbs-siggen 本体は Ruby コードを静的解析して RBS を出力する汎用ツールですが、`siggen/` 以下では Rails の ActiveRecord モデルに特化した RBS 生成の PoC を開発しています。

---

## ファイル構成

```
siggen/
├── activerecord_model.rbs        # ERB テンプレートから生成された RBS 注釈ファイル（コミット対象）
└── activerecord_model.rbs.erb    # ERB テンプレートの元ファイル（こちらを編集する）
siggen-test/
└── activerecord_model_sqlite3/   # RBS をテストするための最小構成 Rails アプリ
```

## RBS 生成の仕組み

`activerecord_model.rbs` は `activerecord_model.rbs.erb` から生成されます。

```bash
ruby -rerb -e 'ERB.new(File.read("siggen/activerecord_model.rbs.erb"), trim_mode: ?-).run' > siggen/activerecord_model.rbs
```

`activerecord_model.rbs` は `%a{siggen: ...}` アノテーションを使って、`db/schema.rb` の `create_table` や各カラム定義（`t.string`, `t.text`, `t.datetime` など）の呼び出しに対して RBS を生成するテンプレートを定義しています。

### カラム型マッピング

| schema.rb のカラム型 | 生成される RBS 型 |
|---|---|
| `bigint` | `::Integer` |
| `binary` | `::String` |
| `boolean` | `bool` |
| `date` | `::Date` |
| `datetime` | `::ActiveSupport::TimeWithZone` |
| `decimal` | `::BigDecimal` |
| `float` | `::Float` |
| `integer` | `::Integer` |
| `json` | `untyped` |
| `string` | `::String` |
| `text` | `::String` |
| `time` | `::ActiveSupport::TimeWithZone` |
| `timestamp` | `::ActiveSupport::TimeWithZone` |
| `virtual` | カラム宣言の `type:` オプションに応じた型 |

`null: false` が指定されている場合は非 nullable 型、それ以外は `?` 付きの nullable 型になります。

### 生成されるメソッド群

各カラムに対して、以下のメソッドが `GeneratedAttributeMethods` モジュール内に生成されます:

- 読み書き: `attr`, `attr=`
- キャスト前: `attr_before_type_cast`, `attr_for_database`, `attr_came_from_user?`
- クエリ: `attr?`
- Dirty tracking (ActiveModel::Dirty + ActiveRecord::AttributeMethods::Dirty): 計 12 メソッド
  - `attr_changed?`, `attr_change`, `attr_was`, etc.

## テスト用 Rails アプリ (`siggen-test/activerecord_model_sqlite3/`)

生成した RBS が正しいかを型チェッカーで検証するための最小構成 Rails アプリです。

- **Rails**: 8.1.3
- **DB**: SQLite3
- **モデル**: `Post` (`app/models/post.rb`)
- **スキーマ**: `db/schema.rb`（`posts` テーブル: `id`, `body:text`, `title:string`, `created_at:datetime`, `updated_at:datetime`）
- **生成済み RBS**: `sig/siggen.rbs`（`activerecord_model.rbs` を使って `db/schema.rb` を解析した出力）

### テスト実行

```bash
cd siggen-test/activerecord_model_sqlite3
bundle exec rails test
```

### Steep による型チェック

生成した `sig/siggen.rbs` が正しく型付けされているかを Steep で検証できます。

```bash
cd siggen-test/activerecord_model_sqlite3
bundle install
bundle exec rbs collection install   # gem の RBS を収集（初回のみ）
bundle exec steep check               # 型チェック実行
```

#### 設定ファイルの役割

| ファイル | 役割 |
|---|---|
| `Steepfile` | 型チェック対象（`test/models/post_test.rb`）と使用ライブラリ（`minitest`）を指定 |
| `rbs_collection.yaml` | `minitest` の RBS 収集設定 |
| `sig/app.rbs` | Rails フレームワーク（`ActiveRecord::Base`, `ApplicationRecord`, `ActiveSupport::TestCase`）の最小限スタブ |
| `sig/siggen.rbs` | rbs-siggen が生成した `Post` モデルの RBS（`class Post < ::ApplicationRecord` を宣言） |

#### `sig/siggen.rbs` の親クラス宣言について

`sig/siggen.rbs` は `class Post < ::ApplicationRecord` と親クラスを明示しています。
これにより `Post.first!` の戻り値型が `Post`（non-nil）として推論され、`post.title` の型検査が正しく機能します。

テストコード（`post_test.rb`）では `Post.first`（戻り値 `Post?`）ではなく `Post.first!`（戻り値 `Post`）を使用することで、nil チェックなしに `post.title` を呼び出せます。

### RBS の再生成

プロジェクトルートから rbs-siggen CLI の `--rails` フラグを使って生成できます（実装が進んだ段階）:

```bash
rbs-siggen --rails
```

---

## 関連ファイル（プロジェクトルート）

- [README.md](../README.md) — rbs-siggen 本体の説明（`--rails` フラグの説明あり）
- [lib/](../lib/) — rbs-siggen 本体の実装
- [sig/](../sig/) — rbs-siggen 本体の RBS 定義
