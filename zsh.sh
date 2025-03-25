#!/bin/bash

# 更新并安装必要的软件包
sudo apt update && sudo apt upgrade -y
sudo apt install -y zsh git curl wget ca-certificates

# 安装 zsh 插件管理器 - oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 设置 zsh 为默认 shell
chsh -s $(which zsh)

# 安装常见插件
echo "正在安装常见插件..."

# 安装 zsh-autosuggestions 插件（命令自动补全建议）
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# 安装 zsh-syntax-highlighting 插件（命令高亮）
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# 安装 powerlevel10k 主题（一个美观的 Zsh 主题）
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# 配置 .zshrc 文件
echo "配置 .zshrc 文件..."

# 设置 powerlevel10k 主题
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/' ~/.zshrc

# 启用常用插件：git, zsh-autosuggestions, zsh-syntax-highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 重新加载 zsh 配置
source ~/.zshrc

# 提示用户重新启动终端
echo "Zsh 安装及配置完成！请重新启动终端，或者执行 'zsh' 以启用新的配置。"
