require 'rails_helper'

RSpec.describe ExpenseRequest, type: :model do
    it 'is valid with valid attributes' do
      expense_request_1 = build(:expense_request)
      expect(expense_request_1).to be_valid
    end

    it 'is not valid with nil invoice number' do
        expense_request_1 = build(:expense_request, invoice_number: nil)
        expect(expense_request_1).to_not be_valid
    end

    it 'is not valid with nil amount' do
        expense_request_1 = build(:expense_request, amount: 0.0)
        expect(expense_request_1).to_not be_valid
    end  

end