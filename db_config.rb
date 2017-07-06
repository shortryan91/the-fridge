require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'add_ingredient'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)
