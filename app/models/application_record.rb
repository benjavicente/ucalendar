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

  # https://stackoverflow.com/a/36335591
  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def self.short_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.short_name.#{enum_value}")
  end
end
