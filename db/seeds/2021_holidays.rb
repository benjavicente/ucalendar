# frozen_string_literal: true

Holiday.create! do |h|
  h.name = 'Viernes Santo'
  h.day  = '2021-04-02'
end

Holiday.create! do |h|
  h.name = 'Sábado Santo'
  h.day  = '2021-04-03'
end

Holiday.create! do |h|
  h.name = 'Suspensión de las actividades académicas y administrativas'
  h.day  = '2021-04-30'
end

(10..15).each do |day|
  Holiday.create! do |h|
    h.name = 'Semana de receso'
    h.day  = "2021-05-#{day}"
  end
end

Holiday.create! do |h|
  h.name = 'San Pedro y San Pablo'
  h.day  = '2021-06-28'
end

Holiday.create! do |h|
  h.name = 'Suspensión de las actividades académicas y administrativas'
  h.day  = '2020-09-17'
end
