
require 'rubygems'
require 'nokogiri'
require 'open-uri'

course_url = "http://nptel.iitm.ac.in/video.php?subjectId=106105079"
page = Nokogiri::HTML(open(course_url))   
content =  page.css('script')  # => Nokogiri::HTML::Document

# Find Video ID
if course_url =~ /subjectId/i
	video_id = ''
	content.each do |c|
		#puts c 
		if c.to_s =~ /loadLecture\(\'/
			puts c 
			video_id =  c.to_s.split('\'')[1]
		end
	end


	POST_URL = "http://nptel.iitm.ac.in/showVideo.php"
	course_content = Net::HTTP.post_form(URI.parse(POST_URL), 
	                               {'v'=>video_id})
	content =  course_content.body
	page = Nokogiri::HTML(content)
else
	page = Nokogiri::HTML(open(course_url))
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
  	puts "course under review"
  else
  	puts "NOT under review"
  end



# Get content wrt to the videoid