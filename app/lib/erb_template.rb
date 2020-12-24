# frozen_string_literal: true

require 'erb'

# Clase para cargar templates del directorio app/remplates
class ErbTemplate
  def initialize(template)
    @template = IO.read Rails.root.join('app', 'templates', "#{template}.erb")
  end

  def render(binding_obj)
    ERB.new(@template.strip.gsub(/^ */, ''), trim_mode: '-').result(binding_obj)
  end
end
