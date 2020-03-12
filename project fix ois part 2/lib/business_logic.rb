# BusinessLogic
module BusinessLogic
  require 'database'
  require 'students'
  require 'courses'
  require 'parse_helper'
  require 'arguments_parser'
  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/CyclomaticComplexity
  # rubocop: disable Metrics/PerceivedComplexity
  def self.business_logic(options)
    return abort 'This program can not run whitout database config file yml.' \
    unless options[:db_config_file]

    Database.open(options[:db_config_file], options[:db_env] || 'development')

    exit import_data(options) if options[:students_file] \
    || options[:courses_file]

    Students.print_all if options[:print_students]
    Courses.print_all if options[:print_courses]

    exit enrol_student(options) if options[:enrol]
    exit grade_student(options) if options[:grade]

    exit
  end
  # rubocop: enable Metrics/CyclomaticComplexity
  # rubocop: enable Metrics/PerceivedComplexity

  def self.enrol_student(options)
    test_options_student_course(options)

    raise 'Abort' unless (course = Courses.find_course(options[:course])) && \
                         (student = Students.find_student(options[:student]))

    puts "Enrolling #{student} to #{course}"
    raise 'Abort' unless course.enrol(student)

    puts 'Done!'
    true
  rescue StandardError => e
    warn e.message
    abort
  end

  # rubocop: disable Metrics/MethodLength
  def self.grade_student(options)
    test_options_student_course(options)
    array = options[:grade]
    grade = array.slice!(0).to_i

    date = if array.empty?
             Time.now.utc.to_date
           else
             ParseHelper.parse_date(array.to_s.strip)
           end

    raise 'Abort' unless (course = Courses.find_course(options[:course]\
    .to_i)) && (student = Students.find_student(options[:student]))

    puts "Grading #{student.name} in #{course.name} with #{grade}"
    raise 'Abort' unless course.grade_student(student, grade, date)

    puts 'Done!'
    true
  rescue StandardError => e
    warn e.message
    abort
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize

  def self.import_data(options)
    Students.import_from_csv(options[:students_file]) if options[:students_file]
    Courses.import_from_csv(options[:courses_file]) if options[:courses_file]
    puts "Import complete. Exit\n\n"
    true
  end

  def self.test_options_student_course(options)
    raise '--course argument shall be provided' unless options[:course]
    raise '--student argument shall be provided' unless options[:student]
  rescue StandardError => e
    warn e.message
    abort
  end
end
