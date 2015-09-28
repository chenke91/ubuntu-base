# Ubuntu Dockerfile

# 构建命令：sudo docker build -t="<your name>/basic" .

# Pull base image
#基于哪个镜像
FROM index.alauda.cn/alauda/ubuntu

ADD sources.list /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

# install
# 运行命令
RUN \
    apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common && \
    apt-get install -y curl git htop man unzip vim wget && \
    rm -rf /var/lib/apt/lists/*

#MAINTAINER  镜像创建者

# Add files.
ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
# container启动时执行的命令，但是一个Dockerfile中只能有一条CMD命令，多条则只执行最后一条CMD, 可以替换
CMD ["bash"]

# ENTRYPOINT
# container启动时执行的命令，但是一个Dockerfile中只能有一条ENTRYPOINT命令，如果多条，则只执行最后一条

# USER
# 使用哪个用户跑container

# EXPOSE
# container内部服务开启的端口。主机上要用还得在启动container时，做host-container的端口映射：
# docker run -d -p 127.0.0.1:33301:22 centos6-ssh
# container ssh服务的22端口被映射到主机的33301端口

# ENV
# 用来设置环境变量，比如：
# ENV LANG en_US.UTF-8
# ENV LC_ALL en_US.UTF-8

# VOLUME
# 可以将本地文件夹或者其他container的文件夹挂载到container中。

# WORKDIR
# 切换目录用，可以多次切换(相当于cd命令)，对RUN,CMD,ENTRYPOINT生效

# ONBUILD
# ONBUILD 指定的命令在构建镜像时并不执行，而是在它的子镜像中执行

# ADD
# 将文件<src>拷贝到container的文件系统对应的路径<dest>
# 所有拷贝到container中的文件和文件夹权限为0755,uid和gid为0
# 如果文件是可识别的压缩格式，则docker会帮忙解压缩
# 如果要ADD本地文件，则本地文件必须在 docker build <PATH>，指定的<PATH>目录下
# 如果要ADD远程文件，则远程文件必须在 docker build <PATH>，指定的<PATH>目录下。比如:
# docker build github.com/creack/docker-firefox
# docker-firefox目录下必须有Dockerfile和要ADD的文件
# 注意:使用docker build - < somefile方式进行build，是不能直接将本地文件ADD到container中。只能ADD
# url file.
# ADD只有在build镜像的时候运行一次，后面运行container的时候不会再重新加载了。
