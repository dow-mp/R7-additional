class OrdersController < ApplicationController
    # before_action :set_customer

    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
        @customer = Customer.find_by(id: @order.customer_id)
    end

    def new
        @customers = Customer.all
        @order = Order.new
    end

    def edit 
        @order = Order.find(params[:id])
        @customer = Customer.find_by(id: @order.customer_id)
    end

    def create
        customer_name_array = customer_name_param.split(" ")
        customer_last = customer_name_array[1]
        @customer = Customer.find_by(last_name: customer_last)
        @order = @customer.orders.create(order_params)
        redirect_to @customer
    end

    def update
        @order = Order.find(params[:id])
        @order.update(order_params)
        redirect_to @order
    end

    def destroy
        @order = Order.find(params[:id])
        @customer = Customer.find(@order.customer_id)
        @order.destroy
        redirect_to @customer
    end

    private
        def order_params
            params.require(:order).permit(:product_name, :product_count, :customer_id)
        end

        def customer_name_param
            params.require(:full_name)
        end
end
