class Employee < ApplicationRecord
    has_many :expense_group_requests, dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :employee_status, presence: true
  
    attribute :admin_status, :boolean, default: false
  end
  