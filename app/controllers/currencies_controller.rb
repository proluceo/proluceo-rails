class CurrenciesController < ApplicationController
  include ApplicationHelper

  def search
    @currencies = currencies.select{|c| c.include?("#{params[:q].upcase}")}
    render layout: false
  end
end