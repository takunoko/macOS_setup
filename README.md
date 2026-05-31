# macOS Setup

Ansible を使って、macOS の開発環境をまとめてセットアップするためのリポジトリです。

## 何をするか

- Homebrew パッケージのインストール
- Homebrew Cask アプリのインストール
- Mac App Store アプリのインストール

実行対象はローカルマシンのみです。

## 前提

- macOS を使用していること
- App Store から入れるアプリを使う場合は、事前に App Store にサインインしておくこと
- GitHub から clone するための SSH キーを用意すること

## 事前準備

### 1. Xcode Command Line Tools をインストール

```sh
xcode-select --install
```

### 2. Homebrew をインストール

公式サイト: [https://brew.sh/ja/](https://brew.sh/ja/)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

`brew shellenv` の出力を `~/.zprofile` に反映します。

```sh
brew shellenv
```

Apple Silicon の場合は通常 `/opt/homebrew/bin/brew shellenv`、Intel Mac の場合は通常 `/usr/local/bin/brew shellenv` になります。表示された内容を `~/.zprofile` に追記してから、現在のシェルにも反映してください。

```sh
eval "$($(command -v brew) shellenv)"
```

### 3. SSH キーを作成

```sh
ssh-keygen -t ed25519
```

`ed25519` が使えないサービスがある場合は適宜変更してください。

### 4. Git / Ansible をインストール

```sh
brew install git ansible
```

### 5. GitHub に公開鍵を登録

```sh
pbcopy < "$HOME/.ssh/id_ed25519.pub"
```

鍵登録ページ: [https://github.com/settings/keys](https://github.com/settings/keys)

## セットアップ実行

通常のセットアップでは、Homebrew と Homebrew Cask の対象をインストールします。

```sh
git clone git@github.com:takunoko/macOS_setup.git
cd macOS_setup
ansible-playbook setup.yml -i inventory
```

App Store アプリは、App Store にサインインしたあとで明示的に実行します。

```sh
ansible-playbook setup.yml -i inventory --tags mas
```

## 補足

- App Store アプリのインストールは `mas` を使います
- `mas` の処理はデフォルトでは実行されません
- `mas` の処理を通すには、App Store サインイン済みであることが必要です
- インストール対象の一覧は `roles/*/vars/main.yml` で管理しています
