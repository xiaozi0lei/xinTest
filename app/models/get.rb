class Get < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  validates :result, presence: true
end
