class ExpenseRequestsController < ApplicationController

	require 'faraday'
	require 'json'

	skip_before_action :verify_authenticity_token
	before_action :current_user, only: [:update_expense_status]

	def index
		expense = Expense.group(params[:expense_group_id])
		render json: expense
	end


	def create_expense
		employee = Employee.find_by(id: params[:employee_id])
		if employee.employee_status == 'active'
		  expense_group = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
		  expense = expense_group.expense_requests.create!(expense_request_params)
		  if true
			response = make_connection(expense)
			if response["id"]
				expense.update(invoice_validation_result: response['status'])
				if expense.invoice_validation_result
					expense.update(status: 'Approved')
					expense.save!
					render json: expense
			  	else
					expense.update(status: 'Rejected')
					expense.save!
					render json: expense
			  	end
			else
			  render json: "Unable to hit API"
			end
		  end
		end
    end

	def make_connection(expense)
		invoice_id = { "invoice_id": expense.invoice_number }
		api_key = "b490bb80"

		#making connection
		conn = Faraday.new(url: 'https://my.api.mockaroo.com/invoices.json') do |faraday|
			faraday.request :url_encoded
			faraday.headers['X-API-Key'] = api_key
			faraday.adapter Faraday.default_adapter
		end

		#make a post request
		response = conn.post do |req|
			req.headers['Content-Type'] = 'application/json'
			req.body = invoice_id.to_json
		end

		result = JSON.parse(response.body)
		return result
	end

	def show_expenses
		employee = Employee.find_by(id: params[:employee_id])
		expense_group_of_employee = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
		render json: expense_group_of_employee.expense_requests
	end

	def delete_expenses
		employee = Employee.find_by(id: params[:employee_id])
		expense_group = employee.expense_group_requests.find_by(id: params[:exp_grp_id])
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
				expense.update(status: "Approved")	
			else
				expense.update(status: "Rejected")
			end
			expense_group.update_status
		end	
	end


	def validate(expense)
		invoice_number = expense.invoice_number
        Rails.logger.info "Invoice Number: #{invoice_number}"
		if invoice_number.even?
			expense.update(invoice_validation_result: true)
		else
			expense.update(invoice_validation_result: false)
		end

	end


	private 
	def expense_request_params
		params.permit(:invoice_number, :date, :description, :amount, :attachment, :status, :invoice_validation_result)
    end
end
