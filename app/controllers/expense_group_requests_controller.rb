class ExpenseGroupRequestsController < ApplicationController
	skip_before_action :verify_authenticity_token
	#before_action :set_current_user, only: [:update_expense_group]

	def index
	  expense_groups_request = ExpenseGroupRequest.all
	  render json: expense_groups_request
	end
  
	def create_expense_group
	  employee = Employee.find_by(id: params[:employee_id])
  
	  if employee && employee.employee_status == 'active'
		expense_group = employee.expense_group_requests.new(create_expense_group_params)
  
		if expense_group.save
		  render json: required_attributes(expense_group)
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
		authorize user, policy_class: ExpenseGroupRequestPolicy
		employee = Employee.find_by(id: params[:employee_id])
	  
		if user.id == employee.id
		  render json: "Error. User cannot delete their own account"
		else
		  expense_group = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
		  expense_group.update(create_expense_group_params)
	  
		  if expense_group.save
			if expense_group.status == "completed"
			  expense_group.applied_amount = 0
			  expense_group.approved_amount = 0
			  expense_group.expense_requests.each do |expense|
				# Logic for calculating applied_amount and approved_amount
				if expense.status == "Approved"
				  expense_group.approved_amount += expense.amount
				  expense_group.applied_amount += expense.amount
				elsif expense.status == "Rejected"
				  expense_group.applied_amount += expense.amount
				end
			  end
			  expense_group.save
			  render json: "Approval amount updated"
			else
			  render json: expense_group
			end
		  else
			render json: { error: "Error while updating expense group", errors: expense_group.errors.full_messages }, status: :unprocessable_entity
		  end
		end
	  end
	  
	def delete_expense_group
	  employee = Employee.find_by(id: params[:employee_id])
	  expense_group = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
  
	  if expense_group.destroy
		render json: "Expense group destroyed"
	  else
		render json: { error: "Error in deleting expense group" }, status: :unprocessable_entity
	  end
	end
  
	private
  
	def create_expense_group_params
	  params.permit(:title, :applied_amount, :approved_amount, :status)
	end
  end
  