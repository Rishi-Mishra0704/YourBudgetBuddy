class GroupController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @groups = @user.groups.all.order(created_at: :asc)
  end

  def show
    @group = Group.includes(:expenses).find(params[:id])
    @group_expenses = @group.expenses
    @expenses = Expense.where.not(id: @group.expenses.pluck(:id))
  end

  def new
    @group = Group.new
    @group_options = Group.pluck(:name, :icon)
  end

  def create
    @group = Group.new(
      user_id: current_user.id,
      name: group_params[:name],
      icon: group_params[:icon]
    )

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_path(@group), notice: 'Group was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, alert: 'Something went wrong' }
      end
    end
  end

  def add_expense
    @group = Group.find(params[:id])
    @expense = Expense.find(params[:format])
    @group.add_unique_expense(@expense)
    redirect_to group_path(@group), notice: 'Expense updated Successfully'
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon, expenses: [])
  end
end
