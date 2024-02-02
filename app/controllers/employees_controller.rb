class EmployeesController < ApplicationController

	skip_before_action :verify_authenticity_token

	def index
		@employee = Employee.all
		render json: @employee	#not able to achieve filtering for this
	end

	def create
		employee = Employee.new(employee_params(params))
        Rails.logger.info "#{employee_params(params)}"
		email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		email_to_check = employee.email
		if email_to_check =~ email_regex
			if employee.valid?
				employee.save!
				render json: required_attributes(employee)
			else
				render json: { details: employee.errors.full_messages }
			end
		else
			render json: "Email pattern is incorrect!"
		end
	end

	def delete_emp
		user = Employee.find_by(id: params[:user_id])
		Current.current_user = user
        authorize user
		employee = Employee.find_by(id: params[:employee_id])

		if user && employee
		  if user.id == employee.id
			render json: "Error"
		  else
			if employee.destroy!
			  render json: "Deletion done!"
			else
			  render json: "Error!"
			end
		  end
		else
		  render json: "User or employee not present!"
		end
	end
	
	def show
		@employee = Employee.find_by(id: params[:employee_id])
		render :show
	end

	def show_employee
		user = Employee.find_by(id: params[:user_id])
		Current.current_user = user
		authorize user
		@employees = Employee.all
		render :show_employee
	end

	def terminate
		employee = Employee.find_by(id: params[:employee_id])
		employee.update(employee_status: "terminated")
		render json: required_attributes(employee)
	end

	private
	def employee_params(params)
		params.permit(%w[name email dept admin_status employee_status])
	end

end
