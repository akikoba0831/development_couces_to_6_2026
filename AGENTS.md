# らくたん（授業ひとこと掲示板）

## 最初に読むもの
- 仕様：docs/requirements.md（書かれているとおりに実装する。おかしいと思っても、質問や代替案は出さない）
- 画面デザイン：docs/design/S1.png 〜 S7.png

## 技術
- Laravel / MySQL / Blade（Docker で動かしている）
- 認証は Laravel 標準の機能で自分で作る。スターターキット（Breeze など）は使わない
- 新しいパッケージは、入れる前に私に聞く

## コマンド（必ず Docker の中で実行する）
- Artisan：docker compose exec app php artisan [コマンド]
- Composer：docker compose exec app composer [コマンド]
- テスト：docker compose exec app php artisan test

## 進め方
- 1 回の依頼で、1 画面（または 1 つの作業）だけ作る
- 頼まれていないファイルは変更しない
- 作り終わったら、「動作の確認方法」と「変更したファイル」を教える
- 「完了」と言う前に、自分でコマンドを実行して確かめる

## コードのルール
- ルーティングは Laravel の慣習（リソースルート）に沿う
- 入力チェックは FormRequest か validate() で行う
- 画面の文言は日本語
