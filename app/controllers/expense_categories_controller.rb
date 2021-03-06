class ExpenseCategoriesController < ApplicationController
  before_action :set_expense_category, only: [:show, :edit, :update, :destroy]

  # GET /expense_categories
  # GET /expense_categories.json
  def index
    @expense_categories = current_user.expense_categories.all.order('updated_at DESC')
  end

  # GET /expense_categories/1
  # GET /expense_categories/1.json
  def show
  end

  # GET /expense_categories/new
  def new
    @expense_category = current_user.expense_categories.new
    # if !@expense_category.nil?
    #   redirect_to expense_categories_path(:user => params[:user]), :method => :post
    # else
    #
    # end
  end

  def receiptslist
    @expense_categories = current_user.expense_categories.all
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "receiptslist.pdf",:template => "expense_categories/receiptslist.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end
  def search
    @check = current_user.username
    gon.username = @check
  end

  # GET /expense_categories/1/edit
  def edit
  end
  

  # POST /expense_categories
  # POST /expense_categories.json
  def create
    @expense_category = current_user.expense_categories.new(expense_category_params)

    respond_to do |format|
      if @expense_category.save
        format.html { redirect_to expense_categories_path }
        format.json { render :show, status: :created, location: @expense_category }
      else
        format.html { render :new }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expense_categories/1
  # PATCH/PUT /expense_categories/1.json
  def update
    respond_to do |format|
      if @expense_category.update(expense_category_params)
        format.html { redirect_to expense_categories_path, notice: 'Expense category was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense_category }
      else
        format.html { render :edit }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_categories/1
  # DELETE /expense_categories/1.json
  def destroy
    @expense_category.destroy
    Receipt.reindex
    respond_to do |format|
      format.html { redirect_to expense_categories_url}
      format.json { head :no_content }
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_expense_category
    @expense_category = current_user.expense_categories.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_category_params
    params.require(:expense_category).permit(:user_id, :title)
  end

end
