class ExpenseGroupRequest < ApplicationRecord
	has_many :expense_requests, dependent: :destroy
	belongs_to :employee
	validates :applied_amount, presence: true
	validates :title, presence: true, uniqueness: true
end
  