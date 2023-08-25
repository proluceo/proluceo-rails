class Person < ApplicationRecord
  self.schema = :common

  def full_name
    "#{first_name} #{last_name}"
  end
end
