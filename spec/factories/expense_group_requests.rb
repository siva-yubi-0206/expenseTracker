
FactoryBot.define do
  factory :expense_group_request do
    title { 'ExpReport_1' }
    applied_amount { 10000 }
    approved_amount { 0.0 }
    employee
  end
end