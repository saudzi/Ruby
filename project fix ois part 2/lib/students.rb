# Students
module Students
  require 'student'
  require 'csv_importer'
  def self.find_student(name)
    student = Student.find_by(name: name)
    raise "Student #{name} not found in database" unless student

    student
  rescue StandardError => e
    warn e.message
  end

  def self.import_from_csv(file_name)
    puts "Importing students from #{file_name}:"
    table = CsvImporter.to_table(file_name)
    table.each { |item| add_new_student(item) }
    puts ''
  end

  def self.print_all
    puts 'All students sorted by name:'
    Student.order(:name).each { |student| puts student.to_s }
    puts ''
  end

  private_class_method def self.add_new_student(item)
    name = item['name']
    if Student.exists?(name: name)
      warn "#{item['name']} already in database. Will not add"
      nil
    else
      Student.create(name: name)
      puts "#{item['name']} added"
    end
  end
end
