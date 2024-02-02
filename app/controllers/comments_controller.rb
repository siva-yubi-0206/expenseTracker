class CommentController < ApplicationController

	def create_comment
		user = Employee.find_by(id: params[:user_id])
		Current.user = user
		authorize user, policy_class: CommentPolicy
		employee = Employee.find_by(id: params[:employee_id])
		if user.id == employee.id
			render json: "Same user can't create the first comment for their own expense"
		else
			expense_group = employee.expense_group_request.find_by(id: params[:exp_group_id])
			expense = expense_group.expense_request.find_by(id: params[:expense_id])
			comment = expense.comment.new(comment_params)
			if comment.save
				render json: "Comment Made"
				render json: comment
			else
				render json: "Error in posting comment"
			end
		end
	end

	def delete_comment
		employee = Employee.find_by(id: params[:emp_id])
		expense_group = employee.expense_group_request.find_by(id: params[:exp_grp_id])
		expense = expense_group.expense_requets.find_by(id: params[:exp_id])
		comment = expense.comment.find_by(id: params[:comment_id])
		if comment.destroy
			render json: "Comment deleted"
		else
			render json: "Not able to delete comment"
		end
	end

	def reply_comment
		employee = Employee.find_by(id: params[:emp_id])
		expense_group = employee.expense_group_request..find_by(id: params[:exp_grp_id])
		expense = expense_group.expense_request..find_by(id: params[:exp_id])
		comment = expense.comment.find_by(id: params[:comment_id])
		if comment.update(comment_params)
			render json: "reply comment added"
		else
			render json: "error"
		end
	end

	private 
	def comment_params
	
	end
end
