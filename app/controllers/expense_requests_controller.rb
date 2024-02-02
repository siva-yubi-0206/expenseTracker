class ExpenseRequestsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :current_user, only: [:update_expense_status]

	def index
		expense = Expense.group(params[:expense_group_id])
		render json: expense
	end

	def create_expense
		employee = Employee.find_by(id: params[:employee_id])
		if employee.employee_status == 'active'
			expense_group = employee.expense_group_requests.find_by(id: params[:expensegroup_id])
			expense = expense_group.expense_requests.create(expense_request_params)
			if expense.save
				validate(expense)
				render json: expense
			else
				render json: "Error in saving the submitted expense"
			end
		end
	end

	def show_expenses
		employee = Employee.find_by(id: params[:id])
		expense_group_of_employee = employee.expense_group_requests.find_by(id: params[:expg_id])
		render json: expense_group_of_employee.expense_requests
	end

	def delete_expenses
		employee = Employee.find_by(id: params[:employee_id])
		expense_group = employee.expense_group_requests.find_by(id: params[:exp_group_id])
		expense = expense_group.expense_requests.find_by(id: params[:expense_id])

		if expense.destroy
			render json: "Expense destroyed!"
		else
			render json: "Error in destroying expense!"
		end
	end

	def update_expense_status
		user = Employee.find_by(id: params[:user_id])
		Current.current_user = user
		authorize user, policy_class: ExpenseRequestPolicy
		employee = Employee.find_by(id: params[:employee_id])
		if user.id == employee.id
			render json: "Not possible since user and employee are same"
		else
			expense_group = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
			expense = expense_group.expense_requests.find_by(id: params[:expense_id])
			if expense.invoice_validation_result
				expense.update(expense_request_params)
				render json: "Expense updated"	
			else
				render json: "error in updating. invoice validation has failed"
			end
		end
	end

	def validate(expense)
		invoice_number = expense.invoice_number
        Rails.logger.info "Invoice Number: #{invoice_number}"
		if invoice_number.even?
			expense.update(invoice_validation_result: true)
		else
			expense.update(status: "Rejected")
		end

	end

	private 
	def expense_request_params
		params.permit(:invoice_number, :date, :description, :amount, :attachment, :status, :invoice_validation_result)
    end
end
