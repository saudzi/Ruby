# Courses
module Courses
  require 'time'
  require 'date'
  require 'course'
  require 'csv_importer'
  require 'parse_helper'
  def self.find_course(id)
    course = Course.find_by(id: id)
    raise "Course with id #{course_id} not found in database" unless course

    course
  rescue StandardError => e
    warn e.message
  end

  def self.import_from_csv(file_name)
    puts "Importing courses from #{file_name}:"
    table = CsvImporter.to_table(file_name)
    table.each { |item| add_new_course(item) }
    puts ''
  end

  def self.print_all
    puts 'All courses sorted by start date:'
    Course.order(:start_date).each { |course| puts course.to_s }
    puts ''
  end

  private_class_method def self.add_new_course(item)
    date = ParseHelper.parse_date(item['start date dd.mm.YYYY'])
    if Course.exists?(name: item['name'], start_date: date)
      warn "#{item['name']} #{date} already in database. Will not add"
      nil
    else
      Course.create(name: item['name'], start_date: date)
      puts "#{item['name']} #{date} added"
    end
  end
end
