FactoryBot.define do
    factory :expense_request do
      invoice_number { 100 }
      amount { 100 }
      expense_group_request
    end
end