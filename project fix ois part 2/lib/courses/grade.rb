require 'date'
require 'active_record'

# Grade
class Grade < ActiveRecord::Base
  def to_s
    "#{number} on #{date}"
  end
end
