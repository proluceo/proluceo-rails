# frozen_string_literal: true
class TomSelectReflex < ApplicationReflex
  def lookup(model, search)
    self.payload = model.constantize.search(search).map(&:search_result)
    morph :nothing
  end
end
