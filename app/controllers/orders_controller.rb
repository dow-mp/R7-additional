class OrdersController < ApplicationController
    # before_action :set_customer

    def index
        @orders = Order.all
    end

    def show
        p @order
        @order = Order.find(params[:format])
    end

    def new
        @customers = Customer.all
        @order = Order.new
    end

    def edit 
        @order = Order.find(params[:id])
    end

    def create
        # need to figure out how to get the customer id number from the form and pass it along with the order params
        # p customer_name_param
        customer_name_array = customer_name_param.split(" ")
        customer_last = customer_name_array[1]
        @customer = Customer.find_by(last_name: customer_last)
        @order = @customer.orders.create(order_params)
        redirect_to @customer
    end

    def update
        @order = Order.find(params[:id])
        last_arr = params[:full_name].split(" ")
        last = last_arr[1]
        @order.update(order_params)
        @customer = Customer.find_by(last_name: last)
        redirect_to @customer
        # respond_to do |format|
        #     if @order.update(order_params)
        #         format.html { redirect_to customer_order_url(@order), notice = "Order was updated successfully." }
        #         format.json { render :show, status: :ok, location: @order } 
        #     else
        #         format.html { render :edit, status: :unprocessable_entity }
        #         format.json { render json: @order.errors, status: :unprocessable_entity }
        #     end
        # end
    end

    def destroy
        @order = Order.find(params[:id])
        @customer = Customer.find(@order.customer_id)
        @order.destroy
        redirect_to @customer
    end

    private
        def order_params
            params.require(:order).permit(:product_name, :product_count)
        end

        def customer_name_param
            params.require(:full_name)
        end

        # def set_customer
        #     @customer = Customer.find(params[:customer_id])
        # end
end
