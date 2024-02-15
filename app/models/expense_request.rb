class ExpenseRequest < ApplicationRecord
	belongs_to :expense_group_request
	has_many :comments, dependent: :destroy 

	validates :invoice_number, presence: true, uniqueness: true
	validates :amount, presence: true
end
