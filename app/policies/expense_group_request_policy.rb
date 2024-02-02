class ExpenseGroupRequestPolicy < ApplicationPolicy
	
	def update_expense_group?
		user.admin_status?
	end
end 
