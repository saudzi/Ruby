# CSVImporter
module CsvImporter
  require 'file_helper'
  require 'csv'
  def self.to_table(file_name)
    file = FileHelper.open_read(file_name)
    table = CSV.parse(file, headers: true)
    file.close
    table
  rescue StandardError => e
    warn e.message
  end
end
