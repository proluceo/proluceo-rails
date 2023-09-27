class MarketMember < ApplicationRecord
    self.primary_key = [:company_id, :name]
    self.schema = :sales
    belongs_to :company
    has_many :contacts
    has_many :exchanges, foreign_key: [:company_id, :market_member_name]

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
