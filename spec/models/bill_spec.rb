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

RSpec.describe Bill do
  describe '#amount_due' do
    it 'subtracts debits from credits' do
      bill = Bill.create
      bill.credits.create(display_text: 'Item 1', amount: 10.50)
      bill.debits.create(display_text: 'Discount', amount: 0.50)
      expect(bill.amount_due).to eq(10.00)
    end
  end
end
