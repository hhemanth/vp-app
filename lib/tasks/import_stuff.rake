require 'csv'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'       
      


namespace :csv do

  desc "Import CSV Data"
  task :import_stuff => :environment do

    csv_file_path = 'db/courses1.csv'
    CSV.foreach(csv_file_path) do |row|
      row = Course.create!({
        :name => row[0],
        :course_id => row[1],
        :disciplineId => row[2],
        :course_type => row[3],
        :under_development => row[4],        
        :syllabus_link => row[5],        
        :course_link => row[6]        
      })
      puts "Row added!"
    end
  end
end


namespace :db_fill do

desc "Modify db"
  # Check if course is under review
  task :under_review => :environment do
    Course.where("courses.course_link IS NOT NULL AND courses.course_type = 'Video'").each do |c_row|
      course_link = c_row.course_link.to_s
     #Don't process courses with no course link
     if course_link == nil
      next
     end
     # construct the fully qualified course link URL
     base_link = "http://nptel.iitm.ac.in"
     base_link_slash = "http://nptel.iitm.ac.in/"

    if course_link[0] == '/'
      course_link_url = base_link + course_link
    else
      course_link_url = base_link_slash + course_link
    end

    page = Nokogiri::HTML(open(course_link_url))   
    content =  page.css('script')  # => Nokogiri::HTML::Document

    # Find Video ID
    if course_link_url =~ /subjectId/i
      video_id = ''
      content.each do |c|
        #puts c 
        if c.to_s =~ /loadLecture\(\'/
          #puts c 
          video_id =  c.to_s.split('\'')[1]
        end # if
      end #content.each


      POST_URL = "http://nptel.iitm.ac.in/showVideo.php"
      course_content = Net::HTTP.post_form(URI.parse(POST_URL), 
                                     {'v'=>video_id})
      content =  course_content.body
      page = Nokogiri::HTML(content)
    else
      page = Nokogiri::HTML(open(course_link_url))
    end


    brdcrmbs = page.css('div.breadcrumbs')
    #puts brdcrmbs

    course_under_review = false
    #puts brdcrmbs
      brdcrmbs.each do |b|
        if b.text =~ /under review/i
          course_under_review = true
        end
      end

      if course_under_review == true
        puts c_row.course_id.to_s + " " + c_row.course_link.to_s + " :: Under review"
        c_row.update_attribute(:under_review, true)
      else
        puts c_row.course_id.to_s + " " + c_row.course_link.to_s + " :: DONE"
        c_row.update_attribute(:under_review, false)
      end
  
      # Fetch the Page 

      # Check if course is under review using Nokogiri
      # Check status of course as "Under Review"
  end # Courses.all

end # task check_under_review




  task :course_status => :environment do
      phase2_course_list = 'phase2_list.txt'
      phase1_course_list = 'phase1_list.txt'

      #process phase1
    phase1_arr = Array.new
    phase1_set = Set.new
    phase1_arr = IO.readlines phase1_course_list
    phase1_arr = phase1_arr.map{|item| item.gsub("\n", "") }
    phase1_set = phase1_arr.to_set
    puts phase1_set.to_a.to_s



    #process phase2
    phase2_arr = Array.new
    phase2_ins_arr = Array.new

        CSV.foreach(phase2_course_list) do |row|
          phase2_arr.push row[1]
        end

        phase2_set = phase2_arr.to_set



    ctr = 0 
    #for course in phase1 and phase2
    Course.all.each do |c_row|
      if phase1_set.include?(c_row.course_id) || 
         phase2_set.include?(c_row.course_id)
         ctr = ctr + 1
         #puts c_row.course_id
         c_row.update_attribute(:already_processed, true)
         c_row.update_attribute(:has_ppt, "FULL")
       end

      end
      puts "ctr :: " + ctr.to_s
end #task course_status
end # namespace db_fill