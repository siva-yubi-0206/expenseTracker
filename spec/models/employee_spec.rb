require 'rails_helper'

RSpec.describe Employee, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it 'is valid with valid attributes' do
    employee = Employee.new(
      name: 'abc',
      email: 'abc@yubi.com',
      dept: 'IT',
      employee_status: 'active',
      admin_status: false
    )
    expect(employee).to be_valid
  end

  it 'is not valid with empty name' do
    employee = Employee.new(name: nil)
    expect(employee).to_not be_valid
    expect(employee.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without an email' do
    employee = Employee.new(email: nil)
    expect(employee).to_not be_valid
    expect(employee.errors[:email]).to include("can't be blank")
  end

  it 'has a default employee_status of "active"' do
    employee = Employee.new
    expect(employee.employee_status).to eq('active')
  end

  it 'has a default admin_status of false' do
    employee = Employee.new
    expect(employee.admin_status).to be(false)
  end

end
