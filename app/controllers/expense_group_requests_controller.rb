class ExpenseGroupRequestsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :set_current_user, only: [:update_expense_group]
  
	private
  
	def create_expense_group_params
	  params.permit(:title, :applied_amount, :approved_amount)
	end
  
	def set_current_user
	  Current.user = Employee.find_by(id: params[:user_id])
	end
  
	public
  
	def index
	  expense_groups_request = ExpenseGroupRequest.all
	  render json: expense_groups_request
	end
  
	def create_expense_group
		employee = Employee.find_by(id: params[:id])
	  
		if employee && employee.employee_status == 'active'
		  expense_group = employee.expense_group_requests.new(create_expense_group_params)
	  
		  if expense_group.save
			render json: expense_group
		  else
			render json: { error: "Error while creating expense group", errors: expense_group.errors.full_messages }, status: :unprocessable_entity
		  end
		else
		  render json: { error: "Invalid employee or inactive employee" }, status: :unprocessable_entity
		end
	end
	  
  
	def update_expense_group
		user = Employee.find_by(id: params[:user_id])
		Current.current_user = user
		authorize user
		employee = Employee.find_by(id: params[:employee_id])
		if user.id == employee.id
		  render json: "Error. User cannot delete their own account"
		else
		  expense_group = employee.expense_group_requests.find_by(id: params[:expg_id])
		  expense_group.update(expense_group_params)
		  if expense_group.status == "Completed"
			expense_group.applied_amount = 0
			expense_group.approved_amount = 0
			expense_group.expenses.each do |expense|
			  if expense.status == "Approved"
				expense_group.approved_amount += expense.amount
				expense_group.applied_amount += expense.amount
			  elsif expense.status == "Rejected"
				expense_group.applied_amount += expense.amount
			  end
			end
	  
			if expense_group.save
			  render json: "Expense Saved"
			else
			  render json: "Error while saving", status: :unprocessable_entity
			end
	  
			if expense_group.approved_amount == 0
			  ExpenseGroupRequestMailer.with(user: employee.name, title: expense_group.title, applied_amount: expense_group.applied_amount).reject_message.deliver_now
			else
			  ExpenseGroupRequestMailer.with(user: employee.name, title: expense_group.title, applied_amount: expense_group.applied_amount, approved_amount: expense_group.approved_amount).approve_message.deliver_now
			end
		  end
		end
	end	  
  
	def delete_expense_group
	  employee = Employee.find_by(id: params[:employee_id])
	  expense_group = employee.expense_group_requests.find_by(id: params[:expg_id])
  
	  if expense_group.destroy
		render json: "Expense group destroyed"
	  else
		render json: { error: "Error in deleting expense group" }, status: :unprocessable_entity
	  end
	end
  end
  