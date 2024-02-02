class ExpenseRequestPolicy < ApplicationPolicy

	def update_expense_status?
		user.admin_status?
	end
end
