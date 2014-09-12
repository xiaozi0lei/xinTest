class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :project, presence: true
	validates :url, presence: true
	validates :data, presence: true
	validates :result, presence: true
end
