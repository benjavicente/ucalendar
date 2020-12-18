# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.sample(amount = nil)
    if amount.nil?
      find pluck(:id).sample
    else
      find pluck(:id).sample(amount)
    end
  end
end
