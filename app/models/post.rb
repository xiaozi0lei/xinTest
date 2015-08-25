class Post < ActiveRecord::Base
# posts数据库表有5个字段，都是必须有的
  validates :title, presence: true
# 这个字段已经变成下拉列表，所以一定会有值，不需要验证
#validates :project, presence: true
  validates :url, presence: true
# parameter暂时不设置为必选项
#  validates :parameter, presence: true
  validates :data, presence: true
  validates :result, presence: true
end
