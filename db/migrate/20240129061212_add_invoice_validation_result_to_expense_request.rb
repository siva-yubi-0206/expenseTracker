class AddInvoiceValidationResultToExpenseRequest < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_requests, :invoice_validation_result, :boolean
  end
end
