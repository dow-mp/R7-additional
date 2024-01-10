require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  describe "GET /orders (orders_path)" do
    it "renders the index view" do
      customer_list = FactoryBot.create_list(:customer, 10)
      customer_list.each do | customer |
        FactoryBot.create(:order)
      end
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /orders/new (new_order_path)" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe "GET /orders/:id (order_path)" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 83949)
      expect(response).to redirect_to orders_path
    end
  end

  describe "GET /orders/:id/edit (edit_order_path)" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order = FactoryBot.create(:order)
      get edit_customer_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /orders (orders_path) with valid data" do
    it "saves a new entry and redirects top the show path for the entry" do
      customer = FactoryBot.create(:customer)
      customer_attributes = FactoryBot.attributes_for(:customer, full_name: customer.full_name)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect { post orders_path, params: {order: order_attributes, full_name: customer_attributes[:full_name]} }.to change(Order, :count)
      expect(response).to redirect_to("/customers/#{customer.id}")
    end
  end

  describe "does NOT POST /orders (orders_path) with INVALID data" do
    it "does NOT save a new entry or redirect" do
      customer = FactoryBot.create(:customer)
      customer_attributes = FactoryBot.attributes_for(:customer, full_name: customer.full_name)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_count)
      expect { post orders_path, params: {order: order_attributes, full_name: customer_attributes[:full_name]} }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "PATCH /orders/:id (order_path) with valid data" do
    it "updates an order record and redirects to show path for that order" do
      order = FactoryBot.create(:order)
      patch order_path(order.id), params: { order: { product_name: "urtjhsoierh" } }
      order.reload
      expect(order.product_name).to eq("urtjhsoierh")
      expect(response).to redirect_to order_path(id: order.id)
    end
  end

  describe "does NOT PATCH /orders/:id (order_path) with INVALID data" do
    it "does NOT update an order or redirect" do 
      order = FactoryBot.create(:order)
      patch order_path(order.id), params: { order: { product_count: "urtjhsoierh" } }
      order.reload
      expect(order.product_name).not_to eq("urtjhsoierh")
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE an order" do
    it "deletes an order" do
      order = FactoryBot.create(:order)
      expect { delete order_path(order.id) }.to change(Order, :count)
      expect(response).to redirect_to customer_path(id: order.customer_id)
    end
  end
end
