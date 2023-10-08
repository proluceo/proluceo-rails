# frozen_string_literal: true
class TomSelectReflex < ApplicationReflex
  def lookup(search)
    self.payload = Account.search(search).map { |a| { number: a.number.to_s, description: a.description} }
    morph :nothing
  end
end
