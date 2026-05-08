class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: "Usuário atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    redirect_to users_path, notice: "Usuário removido com sucesso"
  end

  def transaction
    @user = User.find(params[:id])

    amount = params[:amount].to_f
    operation = params[:operation]

    if operation == "credit"
      @user.wallet.balance += amount

    elsif operation == "debit"

      if @user.wallet.balance < amount
        redirect_to user_path(@user), alert: "Saldo insuficiente"
        return
      end

      @user.wallet.balance -= amount
    end

    @user.wallet.save

    @user.wallet.transactions.create(
      amount: amount,
      operation: operation
    )

    redirect_to user_path(@user), notice: "Transação realizada com sucesso"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end