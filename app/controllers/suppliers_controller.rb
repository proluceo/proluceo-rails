class SuppliersController < ApplicationController
  SUPPLIERS = ['bidule', 'bidons', 'machin', 'marmite', 'truc', 'tralala']

  def search
    @suppliers = SUPPLIERS.select{|s| s.include?("#{params[:q]}")}
    render layout: false
  end
end