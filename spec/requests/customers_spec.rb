require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  describe "GET /customers (customers_path)" do
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get customers_path
      expect(response).to render_template(:index)
    end
  end
  describe "GET /customers/:id (customer_path)" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the customer id is invalid" do
      get customer_path(id: 5000) # an id that does not exist
      expect(response).to redirect_to customers_path
    end
  end
  describe "GET /customers/new (new_customer_path)" do
    it "renders the :new template" do
      get new_customer_path
      expect(response).to render_template :new
    end
  end
  describe "GET /customers/id/edit (edit_customer_path)" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response).to render_template :edit
  end
  describe "POST /customers (customers_path) with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: { customer: customer_attributes } }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end
  describe "does NOT POST /customers (customers_path) with INVALID data"
    it "does NOT save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: { customer: customer_attributes } }.to_not change(Customer, :count)
      expect(response).to render_template :new
    end
  end
  describe "PUT /customers/:id (customer_path) with valid data" do
    it "updates a customer record and redirects to the show path for that customer record" do
      customer = FactoryBot.create(:customer)
      put customer_path(customer.id), params: { customer: { phone: 1234567890 } }
      customer.reload
      expect(customer.phone).to eq(1234567890)
      expect(response).to redirect_to customer_path(id: customer.id)
    end
  end
  describe "does NOT PUT /customers/:id (customer_path) with INVALID data" do
    it "does NOT update a customer record or redirect" do
      customer = FactoryBot.create(:customer)
      put customer_path(customer.id), params: { customer: { phone: "123" } }
      customer.reload
      expect(customer.phone).not_to eq("123")
      expect(response).to render_template :edit
    end
  end
  describe "DELETE a customer record" do
    it "deletes a customer record" do
      customer = FactoryBot.create(:customer)
      expect { delete customer_path(customer.id) }.to change(Customer, :count)
      expect(response).to redirect_to customers_path
    end
  end
end
