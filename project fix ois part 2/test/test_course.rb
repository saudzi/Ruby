# frozen_string_literal: true

require 'minitest/autorun'
require 'course'
require 'student'
require 'grade'

# Test only public methods not involving other classes
class TestCourseMethods < Minitest::Test
  def setup
    @today = Time.now.utc.to_date
    @course_name = 'my course'
    @course = Course.create(name: @course_name, start_date: @today)
    @course_id = @course.id
  end

  def test_attr_reader
    assert_equal(@course_name, @course.name, 'Check Course name corretness.')
    assert_equal(@today, @course.start_date,
                 'Check Course start_date corretness.')
  end

  def test_to_s
    assert_equal("#{@course_name} (id: #{@course_id}) starts on #{@today}",
                 @course.to_s, 'Check Course to_s method.')
  end
end

# Test course in future and in past
class TestCourseStarted < Minitest::Test
  def setup
    @course_name = 'my course'
    @course_past = Course.create(name: @course_name,
                                 start_date: Date.new(1970, 1, 1))
    @course_future = Course.create(name: @course_name,
                                   start_date: Date.new(2038, 1, 19))
    @course_now = Course.create(name: @course_name,
                                start_date: Time.now.utc.to_date)
  end

  def test_past_start
    # rubocop: disable Metrics/LineLength
    assert_equal(true, @course_past.started?,
                 "Course is not in past, but start date is #{@course_past.start_date}.")
    # rubocop: enable Metrics/LineLength
  end

  def test_future_start
    # rubocop: disable Metrics/LineLength
    assert_equal(false, @course_future.started?,
                 "Course is not in the future, but start date is #{@course_future.start_date}.")
    # rubocop: enable Metrics/LineLength
  end

  def test_now_start
    # Corner case. If course is created now it immediately starts
    # rubocop: disable Metrics/LineLength
    assert_equal(true, @course_now.started?,
                 "Course is not in the past, but start date is #{@course_now.start_date}.")
    # rubocop: enable Metrics/LineLength
  end
end

# Test course enroll
class TestCourseEnroll < Minitest::Test
  # rubocop: disable Metrics/MethodLength
  def setup
    @student_name = 'John Doe'
    @course_past_name = 'Old course'
    @course_future_name = 'Future course'
    @course_past = Course.create(name: @course_past_name,
                                 start_date: Date.new(1970, 1, 1))
    @course_past_id = @course_past.id
    @course_future = Course.create(name: @course_future_name,
                                   start_date: Date.new(2038, 1, 19))
    @student = Student.create(name: @student_name)
    @student_id = @student.id
    err = StringIO.new
    $stderr = err
    # rubocop: enable Metrics/MethodLength
  end

  def test_enrol_fail
    @course_past.enrol(@student)
    # rubocop: disable Metrics/LineLength
    err_string = $stderr.string.gsub(/[\r\n]/, '')
    assert_equal("Can not enrol #{@student_name}. #{@course_past_name} (id: #{@course_past_id}) start is in past.",
                 err_string, 'Check enrol exception handler correctness.')
    # rubocop: enable Metrics/LineLength
    assert_equal(false, @course_past.enrolled?(@student),
                 'Check enrolled? method correctness.')
  end

  def test_enrol_sucess
    @course_future.enrol(@student)
    assert_equal(true, @course_future.enrolled?(@student),
                 'Check enrolled? method correctness.')
  end
end

# Test Course grade
class TestCourseGrade < Minitest::Test
  def setup
    @student_name = 'John Doe'
    @student_grade = 3
    @date = Date.new(2038, 1, 19)
    @student = Student.create(name: @student_name)
    @course = Course.create(name: 'my course', start_date: @date)
    err = StringIO.new
    $stderr = err
  end

  def test_grade_fail
    @course.grade_student(@student, @student_grade, @date)
    err_string = $stderr.string.gsub(/[\r\n]/, '')
    assert_equal("Can not grade not enrolled #{@student_name}.",
                 err_string,
                 'Check grade exception handler correctness.')
  end

  def test_grade_sucess
    @course.enrol(@student)
    @course.grade_student(@student, @student_grade, @date)
    grade = @course.student_grade(@student)
    assert_equal(@student_grade, grade.number,
                 'Check grade methods correctness for grade number.')
    assert_equal(@date, grade.date,
                 'Check grade methods correctness for grade date.')
    assert_kind_of(Grade, grade,
                   'student_grade does not return Grade instance.')
  end
end
