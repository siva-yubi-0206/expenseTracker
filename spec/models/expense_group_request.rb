require 'rails_helper'

RSpec.describe ExpenseGroupRequest, type: :model do
    it 'is valid with valid attributes' do
        employee = create(:employee)
        expense_group_request = ExpenseGroupRequest.new(
          title: 'ExpReport_1',
          applied_amount: 10000,
          employee: employee
        )
        expect(expense_group_request).to be_valid
    end

    it 'is not valid without a title' do
        expense_group_request = ExpenseGroupRequest.new(title: nil)
        expect(expense_group_request).to_not be_valid
        expect(expense_group_request.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a duplicate title' do
        existing_request = create(:expense_group_request, title: 'ExpReport_1')
        expense_group_request = build(:expense_group_request, title: 'ExpReport_1')
        expect(expense_group_request).to_not be_valid
        expect(expense_group_request.errors[:title]).to include('has already been taken')
    end

    it 'is not valid without applied_amount' do
        expense_group_request = ExpenseGroupRequest.new(applied_amount: nil)
        expect(expense_group_request).to_not be_valid
        expect(expense_group_request.errors[:applied_amount]).to include("can't be blank")
    end
end