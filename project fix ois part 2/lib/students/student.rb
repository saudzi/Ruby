require 'active_record'
# Student
class Student < ActiveRecord::Base
  def to_s
    "#{name} (id: #{id})"
  end
end
