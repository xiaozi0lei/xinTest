class Post < ActiveRecord::Base
# posts数据库表有5个字段，都是必须有的
  validates :title, presence: true
  validates :project, presence: true
  validates :url, presence: true
  validates :data, presence: true
  validates :result, presence: true
end
