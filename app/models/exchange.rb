class Exchange < ApplicationRecord
  self.schema = :sales
  belongs_to :market_member, foreign_key: [:company_id, :market_member_name]

  scope :by_recently_created, -> { order(happened_at: :desc) }

  def mean_icon
    icon = { color: '', name: '' }
    if mean == 'call'
      icon[:name] = 'phone'
      icon[:color] = 'bg-amber-500'
    elsif mean == 'email'
      icon[:name] = 'envelope'
      icon[:color] = 'bg-teal-400'
    else
      icon[:name] = 'users'
      icon[:color] = 'bg-blue-500'
    end
    return icon;
  end
end
