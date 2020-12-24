# frozen_string_literal: true

# Extención de clase base
class DateTime
  # Cambia el día de semana a la entregada,
  # solo considerando el dia actual y posteriores
  def change_wday(week_day)
    self + (week_day - wday) % 7
  end
end
