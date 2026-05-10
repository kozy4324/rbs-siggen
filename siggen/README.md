# siggen/

このディレクトリは **rbs-siggen の Rails/ActiveRecord 向け RBS 生成** に関する作業領域です。

rbs-siggen 本体は Ruby コードを静的解析して RBS を出力する汎用ツールですが、`siggen/` 以下では Rails の ActiveRecord モデルに特化した RBS 生成の PoC を開発しています。

---

## ファイル構成

```
siggen/
├── activerecord_model.rbs        # ERB テンプレートから生成された RBS 注釈ファイル（コミット対象）
├── activerecord_model.rbs.erb    # ERB テンプレートの元ファイル（こちらを編集する）
└── test/
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

## テスト用 Rails アプリ (`test/activerecord_model_sqlite3/`)

生成した RBS が正しいかを型チェッカーで検証するための最小構成 Rails アプリです。

- **Rails**: 8.1.3
- **DB**: SQLite3
- **モデル**: `Post` (`app/models/post.rb`)
- **スキーマ**: `db/schema.rb`（`posts` テーブル: `id`, `body:text`, `title:string`, `created_at:datetime`, `updated_at:datetime`）
- **生成済み RBS**: `sig/siggen.rbs`（`activerecord_model.rbs` を使って `db/schema.rb` を解析した出力）

### テスト実行

```bash
cd siggen/test/activerecord_model_sqlite3
bundle exec rails test
```

### RBS の再生成

プロジェクトルートから rbs-siggen CLI の `--rails` フラグを使って生成できます（実装が進んだ段階）:

```bash
rbs-siggen --rails
```

---

## 今後の作業メモ

> **このセクションは会話の中で明らかになった内容を随時追記してください。**

- [ ] 生成された `sig/siggen.rbs` に対して Steep などの型チェッカーによる検証を組み込む
- [ ] テスト用 Rails アプリに型チェック設定（`Steepfile` 等）を追加する
- [ ] `virtual` カラム型の型マッピングを確認・テストする
- [ ] composite primary key のケース（`id: false` + `primary_key: [...]`）の扱いを整理する

---

## 関連ファイル（プロジェクトルート）

- [README.md](../README.md) — rbs-siggen 本体の説明（`--rails` フラグの説明あり）
- [lib/](../lib/) — rbs-siggen 本体の実装
- [sig/](../sig/) — rbs-siggen 本体の RBS 定義
