# prezto: https://github.com/sorin-ionescu/prezto

echo "Start zshprezto initialize"

# clone perzto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"


# zshでgitコマンドをつかうときに自動で^をエスケープしてくれるプラグイン
curl https://raw.githubusercontent.com/knu/zsh-git-escape-magic/master/git-escape-magic > ${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/git-escape-magic

# setup
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo "Finish zshprezto initialize"
