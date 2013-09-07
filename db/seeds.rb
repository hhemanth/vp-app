# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Department.delete_all


Department.create(:dept_name=>'Aerospace Engineering', :dept_id=>'101')
Department.create(:dept_name=>'Atmospheric Science', :dept_id=>'119')
Department.create(:dept_name=>'Automobile Engineering', :dept_id=>'125')
Department.create(:dept_name=>'Basic courses', :dept_id=>'122')

Department.create(:dept_name=>'Biotechnology', :dept_id=>'102')
Department.create(:dept_name=>'Chemical Engineering', :dept_id=>'103')
Department.create(:dept_name=>'Chemistry and Biochemistry', :dept_id=>'104')
Department.create(:dept_name=>'Civil Engineering', :dept_id=>'105')

Department.create(:dept_name=>'Computer Science and Engineering', :dept_id=>'106')
Department.create(:dept_name=>'Electrical Engineering', :dept_id=>'108')
Department.create(:dept_name=>'Electronics & Communication Engineering', :dept_id=>'117')
Department.create(:dept_name=>'Engineering Design', :dept_id=>'107')

Department.create(:dept_name=>'Environmental Science', :dept_id=>'120')
Department.create(:dept_name=>'General', :dept_id=>'121')
Department.create(:dept_name=>'Humanities and Social Sciences', :dept_id=>'109')
Department.create(:dept_name=>'Management', :dept_id=>'110')

Department.create(:dept_name=>'Mathematics', :dept_id=>'111')
Department.create(:dept_name=>'Mechanical Engineering', :dept_id=>'112')
Department.create(:dept_name=>'Metallurgy and Material Science', :dept_id=>'113')
Department.create(:dept_name=>'Mining Engineering', :dept_id=>'123')

Department.create(:dept_name=>'Nanotechnology', :dept_id=>'118')
Department.create(:dept_name=>'Ocean Engineering', :dept_id=>'114')
Department.create(:dept_name=>'Physics', :dept_id=>'115')
Department.create(:dept_name=>'Textile Engineering', :dept_id=>'116')