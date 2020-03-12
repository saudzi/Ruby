# frozen_string_literal: true

require 'minitest/autorun'
require 'student'

# Test only public methods
class TestStudentMethods < MiniTest::Test
  def setup
    @student_name = 'Jane Doe'
    @student_name2 = 'John Doe'
    @student = Student.create(name: @student_name)
    @student_id = @student.id
  end

  def test_name_getter
    assert_equal(@student_name, @student.name,
                 'Check Student name "getter" correctness.')
  end

  def test_name_to_s
    assert_equal("#{@student_name} (id: #{@student_id})", @student.to_s,
                 'Check Student name to string correctness.')
  end

  def test_name_setter
    @student.update(name: @student_name2)
    assert_equal(@student_name2, @student.name,
                 'Check Student name "setter" correctness.')
  end
end
