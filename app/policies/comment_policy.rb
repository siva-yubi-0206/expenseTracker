class CommentPolicy < ApplicationPolicy
	def create_comment?
		user.admin_status?
	end
end
