# This is a custom version of Oh-my-zsh and lots of options for zshrc file

You can read more about Oh-my-zsh [here]( https://github.com/robbyrussell/oh-my-zsh )

### Basic Installation

Method 1)

######  Wget the install script:

`sh -c "$(wget https://raw.githubusercontent.com/vitor-kato/my-zsh/master/script.sh -O -)"`

Method 2)
###### Download the repo
- `git clone https://github.com/vitor-kato/my-zsh.git && cd my-zsh`

###### [Install Zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
- On Unbutu/Debian OS
`sudo apt-get install zsh`

###### Then download Oh-my-zsh
- `sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" `

###### [This adds the syntax highlithing plugin]( https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md )  
- `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

###### Then make a symbolic link to the zshrc file

`ln -sf $(pwd)/zshrc ~/.zshrc`
