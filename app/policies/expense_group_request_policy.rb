class ExpenseGroupRequestPolicy < ApplicationPolicy
	def update_expense_group?
		user.admin?
	end
end 
