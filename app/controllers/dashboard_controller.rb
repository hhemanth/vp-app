class DashboardController < ApplicationController
  def by_dept
  	@url_dept_id = params[:dept_id]
  	@course_arr = Course.find_all_by_disciplineId_and_course_type(@url_dept_id, "Video") 
  end

#mark the cousres which have been ticked as FULL ppt
def change_course_status
    ppt_option= params[:ppt_options]
  	courses_checked= params[:course_checkbox]
  	if ppt_option == "Has PPT"
  		course_ppt_status = "FULL"
  	elsif ppt_option == "Has NO PPT"
         course_ppt_status = "NO PPT"
    elsif ppt_option == "Has Partial PPT"
    	 course_ppt_status = "PARTIAL PPT"
  	end

    mark_courses_with_ppt(courses_checked, course_ppt_status)
  	redirect_to "/"

end
  def mark_courses_with_ppt(courses_selected, c_status)
  	#@courses_checked = Array.new	
  	courses_selected.each do |check|
       course_id = check
       crs=Course.find_by_course_id(course_id)
       crs.update_attribute(:has_ppt, c_status)
       #@courses_checked.push(course_id)
    end
  end
end
