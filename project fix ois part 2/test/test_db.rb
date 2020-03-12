# frozen_string_literal: true

require 'database'

# This is rather awkward way to open database, but it can not be properly
# done from Rakefile test task
Database.open('config/database.yml', 'unit_test')
require 'schema'
