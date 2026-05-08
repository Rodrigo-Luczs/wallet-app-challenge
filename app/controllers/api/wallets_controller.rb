class Api::WalletsController < ApplicationController
  protect_from_forgery with: :null_session

  def balance
    wallet = Wallet.find(params[:id])

    render json: {
      balance: wallet.balance
    }
  end

  def transactions
  wallet = Wallet.find(params[:id])

  transactions = wallet.transactions

  if params[:start_date].present? && params[:end_date].present?
    transactions = transactions.where(
      created_at: params[:start_date]..params[:end_date]
    )
  end

  render json: transactions.order(created_at: :desc)
end

  def transaction
    wallet = Wallet.find(params[:id])

    amount = params[:amount].to_f
    operation = params[:operation]

    if operation == "credit"
      wallet.balance += amount
    elsif operation == "debit"
      wallet.balance -= amount
    end

    wallet.save

    transaction = wallet.transactions.create(
      amount: amount,
      operation: operation
    )

    render json: {
      message: "Transaction created",
      balance: wallet.balance,
      transaction: transaction
    }
  end
end