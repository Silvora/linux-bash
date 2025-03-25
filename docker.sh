#!/bin/bash

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用root用户或通过sudo运行此脚本"
    exit 1
fi

# 安装Docker但不运行任何容器
install_docker_only() {
    echo "正在安装Docker..."
    # 卸载旧版本
    apt-get remove -y docker docker-engine docker.io containerd runc

    # 安装依赖
    apt-get update
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # 添加Docker官方GPG密钥
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # 设置稳定版仓库
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 安装Docker引擎
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io

    # 验证安装
    docker --version
    echo "Docker安装完成！"
}

# 只拉取镜像不运行
pull_images_only() {
    echo "正在拉取MySQL镜像..."
    docker pull mysql:latest
    
    echo "正在拉取Redis镜像..."
    docker pull redis:latest
    
    echo "正在拉取PostgreSQL镜像..."
    docker pull postgres:latest
    
    echo "所有镜像已拉取完成！"
    echo "当前镜像列表："
    docker images
}

# 主菜单
main() {
    echo "开始安装Docker和下载数据库镜像..."
    
    # 安装Docker
    install_docker_only
    
    # 拉取镜像
    pull_images_only
}

# 执行主函数
main