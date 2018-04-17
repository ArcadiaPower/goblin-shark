class Debit < BillItem
  def to_s
    "#{label}: (#{'%.2f' % amount})"
  end

  def to_f
    amount
  end
end
