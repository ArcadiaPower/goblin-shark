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

RSpec.describe BillItem do
  let(:bill) { Bill.create }
  let(:credit) { BillItem.create(amount: 12.50, display_text: 'Shiny Thing', type: 'Credit', bill: bill) }
  let(:debit) { BillItem.create(amount: 5.00, display_text: 'Bonus', type: 'Debit', bill: bill) }

  describe 'Credit' do
    it 'displays the line item text' do
      expect(credit.to_s).to eq('Shiny Thing: 12.50')
    end
  end

  describe 'Debit' do
    it 'displays the line item text' do
      expect(debit.to_s).to eq('Bonus: (5.00)')
    end
  end

  describe 'Observable' do
    it 'changes the Bill total when a BillItem is updated' do
      credit.amount = 25
      credit.save!
      expect(bill.total).to eq(25)
    end

    it 'registers 1 observer after being initialized' do
      expect(credit.count_observers).to eq(1)
    end
  end
end
