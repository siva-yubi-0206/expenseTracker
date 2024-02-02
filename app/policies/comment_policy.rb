class CommentPolicy < ApplicationPolicy
	def create_comment?
		user.admin?
	end
end
