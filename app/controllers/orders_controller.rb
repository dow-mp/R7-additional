class OrdersController < ApplicationController
    before_action :set_customer

    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
    end

    def new
        @order = Order.new
    end

    def edit 
        @order = Order.find(params[:id])
    end

    def create
        @order = @customer.orders.create(order_params)
        redirect_to @customer
    end

    def update
        @order = Order.find(params[:id])
        @order.update(order_params)
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
        @order.destroy
        redirect_to @customer
    end

    private
        def order_params
            params.require(:order).permit(:product_name, :product_count)
        end

        def set_customer
            @customer = Customer.find(params[:customer_id])
        end
end
