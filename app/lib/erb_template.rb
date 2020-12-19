# frozen_string_literal: true

require 'erb'

# Clase para cargar templates del directorio app/remplates
class ErbTemplate
  def initialize(template)
    @file = Rails.root.join('app', 'templates', "#{template}.erb")
  end

  def render(binding_obj)
    ERB.new(IO.read(@file).strip.gsub(/^ */, ''), trim_mode: '-').result(binding_obj)
  end
end
