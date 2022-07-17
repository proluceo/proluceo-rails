module ApplicationHelper
  def current_company
    session[:company] ||= Company.first.id
    Company.find(session[:company])
  end

  def currencies
    ActiveRecord::Base.connection.execute('SELECT * FROM unnest(enum_range(null::accounting.currency)) iso ORDER BY iso::text').map do |row|
      row['iso']
    end
  end
end
