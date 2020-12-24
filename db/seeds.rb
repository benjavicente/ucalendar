# frozen_string_literal: true

User.create!(email: 'admin@example.com', password: '123456') if Rails.env.development?

Term.create! do |t|
  t.year      = 2020
  t.period    = 'tav'
  t.first_day = '2021-01-04'
  t.last_day  = '2021-01-31'
end

Term.create! do |t|
  t.year      = 2021
  t.period    = '1'
  t.first_day = '2021-03-15'
  t.last_day  = '2021-07-09'
end

Term.create! do |t|
  t.year      = 2021
  t.period    = '2'
  t.first_day = '2021-08-09'
  t.last_day  = '2021-12-03'
end

Holiday.create! do |h|
  h.name       = 'Día del trabajo'
  h.day        = '2020-05-01'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Días de las Glorias Navales'
  h.day        = '2020-05-21'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Asunción de la Virgen'
  h.day        = '2020-08-15'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Primera Junta Nacional de Gobierno'
  h.day        = '2020-09-18'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Glorias del Ejército'
  h.day        = '2020-09-19'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Glorias de la Armada'
  h.day        = '2020-09-21'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Celebración del Día del Encuentro de Dos Mundos'
  h.day        = '2020-10-11'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Día de las Iglesias Evangélicas y Protestantes'
  h.day        = '2020-10-31'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Día de Todos los Santos'
  h.day        = '2020-11-01'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Inmaculada Concepción de la Virgen'
  h.day        = '2020-12-08'
  h.every_year = true
end

Holiday.create! do |h|
  h.name       = 'Navidad'
  h.day        = '2020-12-25'
  h.every_year = true
end

# Carga seeds adicionales

Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
  load seed
end
