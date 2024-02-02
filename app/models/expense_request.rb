class ExpenseRequest < ApplicationRecord
	belongs_to :expense_group_request
	has_many :comments, dependent: :destroy 
end
