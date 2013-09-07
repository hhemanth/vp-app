class Course < ActiveRecord::Base
  attr_accessible :course_id, :name, :course_id , :disciplineId, :course_type , :under_development, :syllabus_link , :course_link  
end
