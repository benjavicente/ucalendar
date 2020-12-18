# frozen_string_literal: true

ActiveAdmin.register Course do
  menu priority: 1
  permit_params :term_id, :subject_id, :academic_unit_id, :campus_id, :nrc, :section, :format,
                :total_vacancy, :withdrawal?, :english?, :require_special_approval?
end
