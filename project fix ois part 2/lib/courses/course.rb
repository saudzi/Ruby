require 'database'
require 'time'
require 'date'
require 'grade'

# Course
class Course < Database::ApplicationRecord
  def enrol(student)
    if started?
      raise "Can not enrol #{student.name}. #{name} (id: #{id}) " \
      'start is in past.'
    end
    raise "Can not enrol #{student.name}. Already enrolled" \
    if enrolled?(student)

    StudentInCourse.create(course_id: id, student_id: student.id)
  rescue StandardError => e
    warn e.message
    false
  end

  def enrolled?(student)
    StudentInCourse.exists?(course_id: id, student_id: student.id)
  end

  def grade_student(student, grade_number, date = Time.now.utc.to_date)
    # rubocop: disable Metrics/LineLength
    raise "Can not grade not enrolled #{student.name}." unless enrolled?(student)

    # rubocop: enable Metrics/LineLength

    student_in_course = StudentInCourse.find_by(course_id: id,
                                                student_id: student.id)
    raise "#{student.name} already graded" if student_in_course.grade_id

    grade = Grade.create(number: grade_number, date: date)
    student_in_course.update(grade_id: grade.id)
  rescue StandardError => e
    warn e.message
  end

  def started?
    Time.now.utc.to_date >= start_date
  end

  def student_grade(student)
    student_in_course = StudentInCourse.find_by(course_id: id,
                                                student_id: student.id)
    raise "#{student}) not enrolled" unless student_in_course

    Grade.find(student_in_course.grade_id)
  rescue StandardError => e
    warn e.message
  end

  def to_s
    "#{name} (id: #{id}) starts on #{start_date}"
  end
end

class StudentInCourse < ActiveRecord::Base
end
