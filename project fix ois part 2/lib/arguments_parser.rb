# ArgumentParser
module ArgumentsParser
  require 'optparse'
  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/BlockLength
  def self.parse_program_arguments
    options = {}
    OptionParser.new do |parser|
      parser.on('-h', '--help', 'Prints this help') do |_v|
        puts parser
        exit
      end
      parser.on('--db-config FILE', 'Database configuration file in yml') do |v|
        options[:db_config_file] = v
      end
      parser.on('--db-enviroment development',
                'Database configuration file environment in configuration '\
                "file. 'development' is default") do |v|
        options[:db_env] = v
      end
      parser.on('--import-students FILE', 'Students list CSV file') do |v|
        options[:students_file] = v
      end
      parser.on('--import-courses FILE', 'Courses list CSV file') do |v|
        options[:courses_file] = v
      end
      parser.on('--print-students Y', 'Print students') do |v|
        options[:print_students] = v
      end
      parser.on('--print-courses Y', 'Print courses') do |v|
        options[:print_courses] = v
      end
      parser.on('--enrol Y', 'Enroll student to course. Requires also '\
                '--student and --course') do |v|
        options[:enrol] = v
      end
      parser.on('--grade grade date', 'Grade student. date is optional. '\
                'Requires also --student and --course') do |v|
        options[:grade] = v
      end
      parser.on('--course ID', 'Course id') do |v|
        options[:course] = v
      end
      parser.on('--student name', 'Student name') do |v|
        options[:student] = v
      end
    end.parse!
    options
  rescue OptionParser::InvalidOption => e
    warn e.message
    puts 'Use -h or --help to get help'
    abort
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/BlockLength
end
