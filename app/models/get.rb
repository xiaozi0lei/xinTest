class Get < ActiveRecord::Base
# gets数据库表中有三个字段，都是必须填写的
  validates :title, presence: true
  validates :url, presence: true
  validates :result, presence: true
end
