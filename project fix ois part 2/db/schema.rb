# frozen_string_literal: true

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :students, force: true do |t|
    t.string :name
  end

  create_table :grades, force: true do |t|
    t.integer :number
    t.date :date
  end

  create_table :courses, force: true do |t|
    t.string :name
    t.date :start_date
  end

  create_table :student_in_courses, force: true do |t|
    t.references :course
    t.references :student
    t.references :grade
  end
end
