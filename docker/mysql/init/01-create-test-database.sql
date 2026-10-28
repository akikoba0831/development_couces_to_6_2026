-- テスト専用の DB（phpunit.xml で使う）。開発用 DB のデータを消さないために分ける
CREATE DATABASE IF NOT EXISTS rakutan_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON rakutan_test.* TO 'rakutan'@'%';
FLUSH PRIVILEGES;
