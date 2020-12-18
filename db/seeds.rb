# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'admin@example.com', password: '123456') if Rails.env.development?

Term.create!(year: 2020, period: 2, first_day: Date.new(2020, 8, 10), last_day: Date.new(2020, 12, 12))
Term.create!(year: 2021, period: :tav, first_day: Date.new(2021, 1, 6), last_day: Date.new(2021, 1, 31))
Term.create!(year: 2021, period: 1, first_day: Date.new(2021, 3, 9), last_day: Date.new(2021, 7, 21))
