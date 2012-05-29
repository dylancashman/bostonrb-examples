# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Donation.create([
  { from: "Mamaroneck Avenue School", 
    amount: 120.0,
    description: "Mamaroneck Avenue School held a bake sale and donated the proceeds"},
  { from: "Pia Philanthropist",
    amount: 240.0,
    description: "Pia sent in this check after being solicited by a phone call."},
  { from: "Donna Donator",
    amount: 100.0,
    description: "Given in cash at a fundraiser dinner."},
  { from: "bobby smith",
    amount: 50.0,
    description: "Bobby donated when solicited over the phone."},
  { from: "Mayra Rodriguez",
    amount: 800.0,
    description: "Sent in check after we met her at an advocacy event."
  }
])