FactoryBot.define do
  factory :employee do
    name { 'factoryworker' }
    email { 'worker1@example.com' }
    dept { 'IT' }
    employee_status { 'active' }
    admin_status { false }
  end
end
