# == Schema Information
#
# Table name: bills
#
#  id         :integer          not null, primary key
#  status     :string
#  total      :decimal(19, 4)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bills_on_account_id  (account_id)
#

class Bill < ActiveRecord::Base
  include AASM

  has_many :credits
  has_many :debits

  aasm column: 'status' do
    state :new, initial: true
    state :ready
    state :processing
    state :paid
    state :void

    event :prepare do
      transitions from: :new, to: :ready
    end

    event :process do
      transitions from: :ready, to: :processing
    end

    event :payment_complete do
      transitions from: :processing, to: :paid
    end

    event :cancel do
      transitions from: [:new, :ready, :processing], to: :void
    end
  end

  def amount_due
    credits.sum(:amount) - debits.sum(:amount)
  end

  def update_total
    self.total = amount_due
    save!
  end
end
