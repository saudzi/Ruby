require 'minitest/autorun'
require 'student'

# Test only public methods
class TestStudentMethods < MiniTest::Test
  def setup
    @student_name = 'Jane Doe'
    @student_name2 = 'John Doe'
    @student = Student.new(@student_name)
  end

  def test_name_getter
    assert_equal(@student_name, @student.name,
                 'Check Student name "getter" correctness.')
  end

  def test_name_to_s
    assert_equal(@student_name, @student.to_s,
                 'Check Student name to string correctness.')
  end

  def test_name_setter
    @student.name = @student_name2
    assert_equal(@student_name2, @student.name,
                 'Check Student name "setter" correctness.')
  end
end
