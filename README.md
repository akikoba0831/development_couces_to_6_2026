# らくたん（授業ひとこと掲示板）開発用リポジトリ

目からぽろっと鱗が落ちる開発講座で使うリポジトリです。
Laravel は導入済みです。このファイルの手順で、自分のパソコンで動かしてください。

> 講座の最後に、このファイルを**自分が作ったアプリの README に書き換えます**。
> 環境構築の手順は、書き換えるときの見本になります。

## 必要なもの

| もの | 確認方法 |
|---|---|
| Git | `git --version` |
| Docker Desktop（起動しておく） | `docker compose version` |

- PHP、Composer、MySQL を自分のパソコンに入れる必要はありません。すべて Docker の中で動きます。
- この環境は、3 つのコンテナ（`web`：画面を返す／`app`：PHP と Laravel／`db`：MySQL）で動きます。

## 環境構築の手順

### 1. まずフォークして、クローンし、自分のブランチを作る

**最初に、このリポジトリを自分の GitHub アカウントへフォーク（コピー）します。**

1. https://github.com/akikoba0831/development_couces_to_6_2026 を開く
2. 右上の **Fork** ボタンを押す
3. 「Create fork」を押す（設定はそのままで大丈夫です）

フォークができたら、**自分のアカウントにできたリポジトリ**をクローンします。

```bash
git clone https://github.com/[自分のGitHubユーザー名]/development_couces_to_6_2026.git rakutan
cd rakutan
git switch -c [自分の名前]
```

- フォークは、配布元のリポジトリを自分のアカウントにコピーすることです。自分のフォークなら、自由に `git push` できます。
- 配布元（`akikoba0831/...`）を直接クローンしないでください。push できません。
- ブランチは、自分専用の作業場所です。名前は半角英数字にします（例：`akiko`）。
- 作業中はこまめに `git commit` します。`git push` は**最後に 1 回**で大丈夫です（push 先は自分のフォークです）。

### 2. 設定ファイルを作る

```bash
cp .env.example .env
```

- Windows の PowerShell の人は `copy .env.example .env` です。
- `.env` は、自分のパソコン用の設定ファイルです（GitHub には送られません）。
- DB の設定は、すでに書いてあります。変更は不要です。

### 3. コンテナを起動する

```bash
docker compose up -d --build
```

- 初回は、ダウンロードとビルドで数分かかります。
- `-d` は「裏で動かす」という意味です。

### 4. PHP の部品（ライブラリ）をそろえる

```bash
docker compose exec app composer install
```

`docker compose exec app` は、「`app` コンテナの中でコマンドを実行する」という意味です。
終わると `vendor` フォルダができます。

### 5. アプリのキーを作る

```bash
docker compose exec app php artisan key:generate
```

### 6. DB を作る（マイグレーション）

```bash
docker compose exec app php artisan migrate
```

エラーが出なければ、MySQL につながっています。
最初はテーブルを 1 つも用意していないので、`Nothing to migrate.` と出れば正常です（テーブルは自分で設計して作ります）。

### 7. ブラウザで確認する

http://localhost:8080 を開いて、Laravel の画面が出れば成功です。

## よく使うコマンド

| やりたいこと | コマンド |
|---|---|
| 起動 | `docker compose up -d` |
| 停止 | `docker compose stop` |
| 状態を見る | `docker compose ps` |
| Artisan（Laravel の道具）を使う | `docker compose exec app php artisan [コマンド]` |
| テストを実行 | `docker compose exec app php artisan test` |
| Composer を使う | `docker compose exec app composer [コマンド]` |
| DB を作り直してダミーデータを入れる | `docker compose exec app php artisan migrate:fresh --seed` |
| ログを見る（エラー調査） | `docker compose logs app` |

- **テスト用の DB**：テストは、開発用とは別の DB（`rakutan_test`）で動きます。設定は済んでいます。

## うまくいかないとき

| 症状 | 対処 |
|---|---|
| `Cannot connect to the Docker daemon` | Docker Desktop を起動する |
| `port is already allocated`（8080 番が使用中） | 使用中のアプリを止める。または `docker-compose.yml` の `8080:80` の左側を変える（例：`8081:80`） |
| `No such file or directory: vendor/autoload.php` | 手順 4 をやっていない。先に実行する |
| `No application encryption key has been specified` | 手順 5 を実行する |
| DB につながらない（`Connection refused`） | 起動して数十秒待ってから、もう一度実行する。それでもだめなら `docker compose ps` で `db` が動いているか見る |
| `Permission denied`（storage や bootstrap/cache） | `docker compose exec app chmod -R 777 storage bootstrap/cache` |
| それでも直らない | エラーを AI エージェントにそのまま貼る。それでも詰まったら、講師に聞く |

## 資料の場所

| ファイル | 内容 |
|---|---|
| `docs/requirements.md` | 要件定義書（何を作るか） |
| `docs/design/S1.png〜S7.png` | 画面デザイン |
| `AGENTS.md` / `CLAUDE.md` | AI エージェントへの指示ファイル（配布済み。中身を読んで、書き方をつかむ） |
