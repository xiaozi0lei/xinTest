#xinTest

web automation test app

##Installation

1. 安装rvm, rvm是ruby version manager.到rvm官网安装 http://rvm.io/

  ```bash
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
  ```

2. 通过rvm安装ruby
  ```bash
  rvm install 2.0.0
  ```

3. 安装git
4. 将github上的xinTest仓库克隆到本地
  ```bash
  git clone git@github.com:xiaozi0lei/xinTest.git
  ```

5. bundle项目所需要的gem包
  ```bash
  cd xinTest
  bundle install
  ```

6. 安装postgreSQL, 配置本地用户信任`sudo vi /etc/postgresql/9.3/main/pg_hba.conf` update the `local   all             postgres                                peer` to `local   all             postgres                                trust`
7. 启动postgreSQL `sudo service postgresql restart`
8. 创建postgres用户 `echo "ALTER USER postgres WITH PASSWORD 'postgres'" | psql -U postgres`
9. 创建数据库 `rake db:create`
10. 数据库迁移 `rake db:migrate`
11. 启动程序 `rails s`

##docker

1. 启动官方postgreSQL数据库 `docker run --name db -e POSTGRES_PASSWORD=postgres -v /home/docker/db_data:/var/lib/postgresql/data -d postgres`
2. 启动xinTest应用程序 `docker run --name xintest -it --link db:postgres -p 3000:3000 -d xiaozi0lei/xintest`

**第一次执行需要运行一下下面的命令**

1. 进入xintest容器 `docker exec -it xintest /bin/bash`
2. 创建数据库和数据库迁移
  ```bash
  rake db:create
  rake db:migrate
  ```

3. 以后再启动就不需要执行这两步.
4. 通过 IP:3000 访问xintest即可

##CentOS 安装docker
http://docs.docker.com/installation/centos/

