# frozen_string_literal: true

class TermsController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: Term.all.map(&:to_s) }
    end
  end
end
