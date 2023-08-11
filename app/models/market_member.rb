class MarketMember < ApplicationRecord
    self.primary_key = [:company_id, :name]
    self.schema = :sales
    belongs_to :company
    has_many :contacts, foreign_key: [:company_id, :market_member_name]
    has_many :exchanges

    accepts_nested_attributes_for :contacts
    accepts_nested_attributes_for :exchanges

    class << self
      def search(params)
        params[:query].blank? ? all : where(
          "name ?", "%#{params[:query]}%"
        )
      end
    end
  end
