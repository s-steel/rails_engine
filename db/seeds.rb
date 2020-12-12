# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
csv_text = File.read('db/data/items.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  i = Item.new
  i.id =row["id"].to_i
  i.name = row["name"]
  i.description = row["description"]
  i.unit_price = (row["unit_price"].to_f / 100)
  i.merchant_id = row["merchant_id"].to_i
  i.created_at = row["created_at"]
  i.updated_at = row["updated_at"]
  i.save
end

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)


ActiveRecord::Base.connection.reset_pk_sequence!('customers')
ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
ActiveRecord::Base.connection.reset_pk_sequence!('items')