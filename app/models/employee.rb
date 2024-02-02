class Employee < ApplicationRecord
    has_many :expense_group_requests, dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    attribute :employee_status, :string, default: "active"
    attribute :admin_status, :boolean, default: false


  end
  