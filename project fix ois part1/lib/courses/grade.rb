require 'date'
# classical class grade
class Grade
  attr_reader :number, :date

  def initialize(number, date)
    @number = number
    @date = Date.parse(date.to_s)
  end

  def to_s
    "#{@number} on #{@date}"
  end
end
