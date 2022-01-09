# Setup Mac OS

# Install Xcode
```
xcode-select --install
```

# Install HomeBrew
公式サイト: https://brew.sh/index_ja
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/takunoko/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```
Xcodeが入ってなかったら勝手に入るみたい
一旦、Ansibleのインスコに使いたいので環境変数なども登録しておく

# create ssh-key
```
ssh-keygen -t ed25519
```
(ed25519ではダメなサービスがあれば修正する)

# Setup Git & Github
```
brew install git
```

githubに公開鍵登録
```
cat $HOME/.ssh/id_ed25519.pub | pbcopy
```
鍵登録ページ: https://github.com/settings/keys

# Install Ansible
```
brew install ansible
```

# apply Ansible
```
# 任意のディレクトリで
git clone git@github.com:takunoko/macOS_setup.git
cd macOS_setup
ansible-playbook setup.yml -i inventory
```

