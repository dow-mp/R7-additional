class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found # if a record not found exception occurs, the catch_not_found method is called
  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    # ---------
    # The code contained here does not handle errors - and will display the flash notice despite any errors that may have prevented a save (based on the validation we've implemented)
    # @customer.save
    # flash.notice = "The customer record was created successfully."

    # redirect_to @customer
    # ---------
    
    if @customer.save
      flash.notice = "The customer record was created successfully."
      redirect_to @customer
    else
      render :new, status: :unprocessable_entity # when the status is set to unprocessable_entity, Rails displays any errors that occurred via the html.erb view(s)
    end

    # The code below was automatically generated with the Customer scaffold.
    # respond_to do |format|
    #   if @customer.save
    #     format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
    #     format.json { render :show, status: :created, location: @customer }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    # ---------
    # The code contained here does not handle errors - and will display the flash notice despite any errors that may have prevented an update to the customer (based on the validation we've implemented)
    # @customer.update(customer_params)
    # flash.notice = "The customer record was updated successfully."

    # redirect_to @customer
    # ---------

    if @customer.update(customer_params)
      flash.notice = "The customer record was updated succesfully."
      redirect_to @customer
    else
      render :edit, status: :unprocessable_entity
    end

    # The code below was automatically generated with the Customer scaffold.
    # respond_to do |format|
    #   if @customer.update(customer_params)
    #     format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
    #     format.json { render :show, status: :ok, location: @customer }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def full_name 
    "#{@customer.first_name} #{@customer.last_name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.") # this line writes an entry to the rails log (and the console)
      flash.alert = e.to_s # this line displays the message on the screen for the user by storing the message in the flash object
      redirect_to customers_path # redirects the user back to the index page
    end
end
