'''
require \'rails_helper\'

RSpec.describe EmployeesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new employee and returns the required attributes as JSON" do
        post :create, params: {
          employee: {
            name: "abcdef",
            email: "abcdef@yubi.com",
            dept: "IT",
            employee_status: "active",
            admin_status: true
          }
        }
        #Rails.logger.info "#{response}"
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to include(
          "name" => "abcdef",
          "email" => "abcdef@yubi.com",
          "dept" => "IT",
          "employee_status" => "active",
          "admin_status" => true
        )
      end
    end
  end

end
'''