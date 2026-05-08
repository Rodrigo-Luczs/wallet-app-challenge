class User < ApplicationRecord
  has_one :wallet, dependent: :destroy

  after_create :create_wallet!

  def create_wallet!
    Wallet.create(user: self, balance: 0)
  end
end