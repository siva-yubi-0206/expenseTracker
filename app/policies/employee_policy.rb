class EmployeePolicy < ApplicationPolicy
	def show_employee?
		user.admin_status?
	end
	
	def delete_emp?
		user.admin_status?
	end

	def search_employee?
		user.admin_status?
	end
end
