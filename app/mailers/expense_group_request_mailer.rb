class ExpenseGroupRequestMailer < ApplicationMailer
	def reject_message
		mail(to: params[:user].email, subject: "Expense submision rejection")
	end
	
	def approve_message
		mail(to: params[:user].email, subject: "Expense submission accepted")
	end
end
