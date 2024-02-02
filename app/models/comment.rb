class Comment < ApplicationRecord
	belongs_to :expense
	validates :content, presence: true
end
