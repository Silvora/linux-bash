#!/bin/bash

# 安装nvm并安装Node.js 20
install_nvm_and_node20() {
    # 确保curl已安装
    if ! command -v curl &> /dev/null; then
        echo "正在安装curl..."
        sudo apt-get update && sudo apt-get install -y curl
    fi

    echo "正在下载安装nvm..."
    # 使用官方安装脚本安装nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # 使nvm立即生效
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # 加载nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # 加载nvm bash_completion

    echo "nvm安装完成！"

    # 安装Node.js 20
    echo "正在安装Node.js 20..."
    nvm install 20


    echo "Node.js 20安装完成！"
    echo "当前Node.js版本：$(node -v)"
    echo "当前npm版本：$(npm -v)"
}

# 主函数
main() {
    # 检查是否已安装nvm
    if command -v nvm &> /dev/null; then
        echo "nvm已安装，将直接安装Node.js 20..."
        nvm install 20
        echo "Node.js 20安装完成！"
    else
        install_nvm_and_node20
    fi
}

# 执行主函数
main