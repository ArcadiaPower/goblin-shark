# == Schema Information
#
# Table name: bill_items
#
#  id         :integer          not null, primary key
#  label      :string
#  amount     :decimal(19, 4)
#  type       :string
#  account_id :integer
#  bill_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bill_items_on_account_id  (account_id)
#  index_bill_items_on_bill_id     (bill_id)
#

class BillItem < ActiveRecord::Base
  include Observable

  belongs_to :bill

  after_initialize :register_observers

  def save!
    super
    changed
    notify_observers
  end

  private

    def register_observers
      add_observer(bill, :update_total)
    end
end
