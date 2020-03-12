# DAtabase
module Database
  require 'sqlite3'
  require 'file_helper'
  require 'active_record'

  # Apprecord
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end

  # rubocop: disable Metrics/AbcSize
  def self.open(config_yml, db_env)
    puts "Using database configuration #{config_yml} environment #{db_env}"
    file = FileHelper.open_read(config_yml)
    db_config = parse_config_file(file)
    raise "Database file #{db_config[db_env]['database']} does not exist" \
    unless db_env == 'unit_test' || File.exist?(db_config[db_env]['database'])

    ActiveRecord::Base.establish_connection(db_config[db_env])
  rescue StandardError => e
    warn e.message
    abort
  end
  # rubocop: enable Metrics/AbcSize
  private_class_method def self.parse_config_file(file)
    YAML.safe_load(file)
                       rescue StandardError => e
                         warn "#{e.message} when parsing #{File.basename(file)}"
                         abort
  end
end
