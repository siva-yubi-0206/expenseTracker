class Comment < ApplicationRecord
	belongs_to :expense_request
	has_many :replies, dependent: :destroy
	
	validates :content, presence: true
end
