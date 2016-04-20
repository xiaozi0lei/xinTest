# xinTest

web automation test app

## Installation

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
  git clone git@gitlab.iduoku.cn:sunguolei/apiTest.git
  ```
5. 安装postgreSQL
  ```sh
  audo yum install postgresql-server
  sudo yum install postgresql-devel
  ```

6. 初始化数据库 `sudo service postgresql initdb`
7. 配置本地用户信任
  ```sh
  # ubuntu
  sudo vi /etc/postgresql/9.3/main/pg_hba.conf
  # centos
  sudo vi /var/lib/pgsql/data/pg_hba.conf
  ```
  update the `local   all             postgres                                peer` to `local   all             postgres                                trust`
8. 启动postgreSQL `sudo service postgresql start`

9. bundle项目所需要的gem包
  ```bash
  cd xinTest
  gem sources --remove https://rubygems.org/
  gem sources -a https://ruby.taobao.org/
  gem sources -l
  gem install bundler
  bundle install
  ```

10. 创建数据库 `rake db:create`
11. 数据库迁移 `rake db:migrate`
12. 启动程序 `rails s`

