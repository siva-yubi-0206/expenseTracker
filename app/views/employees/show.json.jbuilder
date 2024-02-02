json.extract! @employee, :id, :name, :email, :dept, :employee_status
json.expense_group_requests(@employee.expense_group_requests) do |expense_group|
    json.title expense_group.title
    json.applied_amount expense_group.applied_amount
    json.approved_amount expense_group.approved_amount
    json.expense_requests(expense_group.expense_requests) do |expense|
        json.invoice_number expense.invoice_number
        json.description expense.description
        json.amount expense.amount
        json.status expense.status
        json.comments(expense.comments) do |comment|
            json.description comment.content
            json.replies(comment.replies) do |reply|
                json.replies reply.replies
            end
        end
    end
end
