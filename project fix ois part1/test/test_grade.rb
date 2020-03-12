require 'minitest/autorun'
require 'grade'

# Test only public methods
class TestGrade < MiniTest::Test
  def setup
    @number = 5
    @date = Time.now.utc.to_date
    @grade = Grade.new(@number, @date)
  end

  def test_grade_getter
    assert_equal(@number, @grade.number,
                 'Check Grade number "getter" correctness.')
    assert_equal(@date, @grade.date, 'Check Grade date "getter" correctness.')
  end

  def test_grade_to_s
    assert_equal("#{@number} on #{@date}", @grade.to_s,
                 'Check Grade to string correctness.')
  end
end
