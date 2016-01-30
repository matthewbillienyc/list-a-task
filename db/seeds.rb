# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create({username: "admin", password: "admin", password_confirmation: "admin", admin: true})
User.create({username: "matthew", password: "password", password_confirmation: "password", admin: false})
User.create({username: "melissa", password: "password", password_confirmation: "password", admin: false})
User.create({username: "mia", password: "password", password_confirmation: "password", admin: false})
