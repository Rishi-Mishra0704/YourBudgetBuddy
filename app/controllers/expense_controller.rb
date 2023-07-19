class ExpenseController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @expenses = @user.expenses.all.order(created_at: :asc)
  end

  def show
    @expense = Expense.find(params[:id])
    @expense_groups = @expense.groups
    @groups = Group.where.not(id: @expense.groups.pluck(:id))
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(
      author_id: current_user.id,
      name: expense_params[:name],
      amount: expense_params[:amount]
    )

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_path(@expense), notice: 'Expense Created Succesfuly' }
      else
        format.html { render :new, status: :unprocessable_entity, alert: 'Something went wrong' }
      end
    end
  end

  def add_group
    @expense = Expense.find(params[:id])
    @group = Group.find(params[:format])
    @expense.add_unique_group(@group)
    redirect_to expense_path(@expense)
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
