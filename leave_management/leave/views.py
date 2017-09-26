from django.shortcuts import render, render_to_response, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib import messages
from django.contrib import auth
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_protect
from django.core.urlresolvers import reverse
from django.db import connection, IntegrityError, transaction
from datetime import datetime, date
import re


# View to login the faculty member or admin
@csrf_protect
def login(request):
	if request.user.is_authenticated():				# Check if user is already logged in

		# Check if user is admin or faculty member and direct to corresponding dashboard
		if request.user.is_staff:
			return HttpResponseRedirect(reverse('admin_dashboard'))
		else:
			return HttpResponseRedirect(reverse('dashboard'))
	if request.POST:								# POST Method
		faculty_id = request.POST['faculty_id']
		password = request.POST['password']
		if faculty_id == '':
			return render(request, 'login.html')

		cursor = connection.cursor()				# Establish connection with MySQL database
		cursor.execute("SELECT * from auth_user where username='"+faculty_id+"';")
		data = cursor.fetchone()
		connection.close()

		if data is not None:				# Check if user is registered
			username = data[4]
			user = auth.authenticate(username=username, password=password)			# Authenticates the username and password
			if user is not None:
				auth.login(request, user)											# Logs in
				if request.user.is_staff:
					return HttpResponseRedirect(reverse('admin_dashboard'))
				else:
					return HttpResponseRedirect(reverse('dashboard'))
			else:																	# User exists but password is incorrect
				messages.error(request, 'The username and password combination is incorrect.')
		else:
			messages.error(request, 'ID not registered.')							# User does not exist
	return render(request, 'login.html')


# View to display the dashboard for the logged-in faculty member
def dashboard(request):
	if not request.user.is_authenticated():								# Directs to login page if user is not logged in
		return HttpResponseRedirect(reverse('login'))
	if request.user.is_staff:
		return HttpResponseRedirect(reverse('admin_dashboard'))			# Directs to admin dashboard if user is admin
	cursor = connection.cursor()
	cursor.execute("SELECT * from faculty_member where faculty_id='"+request.user.username+"';")
	data = cursor.fetchone()
	cursor.execute("SELECT dept_name, faculty from department where dept_id='"+data[2]+"';")
	dep = cursor.fetchone()
	connection.close()

	# Sends details of user to be displayed
	details = {'f_id':data[0], 'name':data[3]+' '+data[4]+' '+data[5], 'desig':data[6], 'email':data[8], 'dept':dep[0], 'fac':dep[1]}
	return render(request, 'dashboard.html', details)


# View for faculty member to apply for a leave
@csrf_protect
def app_leave(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if request.user.is_staff:
		return HttpResponseRedirect(reverse('admin_dashboard'))
	if request.POST:
		start = request.POST['start_date']
		end = request.POST['end_date']
		l_type = request.POST['l_type']

		try:
		    sdate = datetime.strptime(start, '%Y-%m-%d')				# Check if start and end dates entered by the user follow proper format
		    edate = datetime.strptime(end, '%Y-%m-%d')
		except ValueError:
			messages.error(request, 'Error in input. Please enter the dates as YYYY-MM-DD.')
			return HttpResponseRedirect(reverse('app_leave'))

		cursor = connection.cursor()
		cursor.execute("SELECT gender_spec from leave_info where leave_type='"+l_type+"';")
		gender = cursor.fetchone()
		cursor.execute("SELECT gender from faculty_member where faculty_id='"+request.user.username+"';")
		gen = cursor.fetchone()
		if gender[0]!='All' and gender[0][0]!=gen[0][0]:			# Checks if the user is not allowed to the leave due to gender specifications
			messages.error(request, 'This type of leave is not valid for '+gen[0]+' faculty members.')
		elif sdate.date() < date.today():
			messages.error(request, 'Start date cannot be before the current date.')
		elif sdate.date() > edate.date():
			messages.error(request, 'Start date cannot be after end date.')
		else:
			cursor = connection.cursor()					# Calculates unique leave_id combining the user' faculty ID and his total leave requests
			cursor.execute("SELECT * from leave_request where faculty_id='"+request.user.username+"';")
			data = cursor.fetchall()
			l = len(data)
			temp = ''
			for a in request.user.username[::-1]:
				if a.isdigit():
					temp = a + temp
				else:
					break
			leave_id = int(temp + str(l+1))
			cursor.execute("SELECT * from leave_request where leave_id='"+str(leave_id)+"';")
			data = cursor.fetchone()
			cursor.execute("SELECT * from leave_checked where leave_id='"+str(leave_id)+"';")
			data1 = cursor.fetchone()
			i=2
			while data is not None or data1 is not None:			# Loops until a unique leave_id is generated
				leave_id = int(temp + str(l+i))
				print leave_id
				cursor.execute("SELECT * from leave_request where leave_id='"+str(leave_id)+"';")
				data = cursor.fetchone()
				cursor.execute("SELECT * from leave_checked where leave_id='"+str(leave_id)+"';")
				data1 = cursor.fetchone()
				i=i+1
			try:										# Tries to insert input values into the leave_request table
				cursor.execute("INSERT into leave_request values ("+str(leave_id)+", '"+start+"', '"+end+"', '"+request.user.username+"', '"+l_type+"');");
				connection.commit()						# Commits the insertion
			except Exception as e:
				print e
				connection.rollback()
			connection.close()
			messages.success(request, 'Leave request submitted.')			# Displays success error message
			return HttpResponseRedirect(reverse('dashboard'))

	cursor = connection.cursor()
	cursor.execute("SELECT leave_type from leave_info;")				# Passes all the leave types to form if method is not POST
	data = cursor.fetchall()
	connection.close()
	return render(request, 'app_leave.html', {'types':[a[0] for a in data]})


# View to display the past leave requests made by the faculty member
def past_app(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if request.user.is_staff:
		return HttpResponseRedirect(reverse('admin_dashboard'))
	cursor = connection.cursor()

	# Fetch unreviewed leave requests made by the user
	cursor.execute("SELECT leave_id, start_date, end_date, leave_type from leave_request where faculty_id='"+request.user.username+"';")
	old = cursor.fetchall()
	old = tuple(a+(a[0],) for a in old)

	# Fetch reviewed leave requests made by the user
	cursor.execute("SELECT leave_id, start_date, end_date, status, remarks, leave_type from leave_checked where faculty_id='"+request.user.username+"';")
	new = cursor.fetchall()
	connection.close()
	return render(request, 'past_app.html', {'old':old, 'new':new})


# View to delete the yet unreviewed leave requests made by the faculty member
def del_app(request, l_id):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if request.user.is_staff:
		return HttpResponseRedirect(reverse('admin_dashboard'))
	cursor = connection.cursor()

	# Fetches the faculty member who made the request identified by l_id
	cursor.execute("SELECT faculty_id from leave_request where leave_id="+l_id+";")
	data = cursor.fetchone()
	connection.close()
	if data is None or data[0]!=request.user.username:					# Go back if the logged-in user did not make the request l_id
		return HttpResponseRedirect(reverse('dashboard'))
	if request.POST:
		cursor = connection.cursor()									# If yes is clicked, deletion operation is performed on the table leave_request
		try:
			cursor.execute("DELETE from leave_request where leave_id="+l_id+";")
			connection.commit()
		except Exception as e:
			print e
			connection.rollback()
		connection.close()
		messages.success(request, 'Leave request successfully deleted.')
		return HttpResponseRedirect(reverse('past_app'))
	cursor = connection.cursor()

	# Passes the details of the query identified by l_id
	cursor.execute("SELECT leave_id, start_date, end_date, leave_type from leave_request where leave_id="+l_id+";")
	data = cursor.fetchone()
	connection.close()
	return render(request, 'del_app.html', {'l_id': l_id,'data': data})


# View to display the days left for the different leave types of the faculty member
def days_left(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if request.user.is_staff:
		return HttpResponseRedirect(reverse('admin_dashboard'))
	cursor = connection.cursor()

	# Fetches the days left of the applicable leave types for the logged-in faculty member
	cursor.execute("SELECT d.leave_type, l.leave_description, d.no_days_left, l.max_days from days_left d, leave_info l " \
		"where d.leave_type=l.leave_type and d.faculty_id='"+request.user.username+"';")
	data = cursor.fetchall()
	connection.close()
	return render(request, 'days_left.html', {'data': data})


# View to display information of all the leave types
def leave_types(request):
	cursor = connection.cursor()
	
	# Fetches details of lapsable leave types
	cursor.execute("SELECT leave_type, leave_description, max_days, gender_spec from leave_info where lapsable='Y';")
	laps = cursor.fetchall()

	# Fetches details of non-lapsable leave types
	cursor.execute("SELECT leave_type, leave_description, max_days, gender_spec from leave_info where lapsable='N';")
	nlaps = cursor.fetchall()
	connection.close()
	return render(request, 'leave_types.html', {'laps':laps, 'nlaps':nlaps})


# View to display the dashboard for the logged-in admin
def admin_dashboard(request):
	if not request.user.is_authenticated():							# Checks if user is logged in or not
		return HttpResponseRedirect(reverse('login'))
	if not request.user.is_staff:									# Checks if the logged-in user has admin status or not
		return HttpResponseRedirect(reverse('dashboard'))
	cursor = connection.cursor()

	# Fetches unreviewed leave requests
	cursor.execute("SELECT leave_id, start_date, end_date, leave_type, faculty_id from leave_request;")
	new = cursor.fetchall()
	
	# Fetches reviewed leave requests
	cursor.execute("SELECT leave_id, start_date, end_date, status, remarks, leave_type, admin_id, faculty_id from leave_checked;")
	old = cursor.fetchall()
	connection.close()
	return render(request, 'admin_dashboard.html', {'old':old, 'new':new})


# View for the admin to display details of the faculty member identified by fac_id
def faculty(request, fac_id):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if not request.user.is_staff:
		return HttpResponseRedirect(reverse('dashboard'))
	cursor = connection.cursor()
	cursor.execute("SELECT * from faculty_member where faculty_id='"+fac_id+"';")
	data = cursor.fetchone()					# Fetches details of faculty member identified by fac_id
	if data is None:
		messages.error(request, 'Faculty Member with given ID does not exist.')				# Displays error if faculty member does not exist
		return HttpResponseRedirect(reverse('admin_dashboard'))
	cursor.execute("SELECT dept_name, faculty from department where dept_id='"+data[2]+"';")		# Fetches details of department of faculty member
	dep = cursor.fetchone()
	cursor.execute("SELECT leave_type, no_days_left from days_left where faculty_id='"+fac_id+"';")		# Fetches days left of various leave types
	days = cursor.fetchall()
	connection.close()
	details = {'f_id':data[0], 'name':data[3]+' '+data[4]+' '+data[5], 'desig':data[6], 'email':data[8], 'dept':dep[0], 'fac':dep[1], 'days':days}
	return render(request, 'faculty.html', details)


# View for the admin to review leave requests made by the faculty member
def review(request, l_id):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if not request.user.is_staff:
		return HttpResponseRedirect(reverse('dashboard'))
	cursor = connection.cursor()
	cursor.execute("SELECT * from leave_request where leave_id='"+l_id+"';")			# Fetches details of request to be reviewed
	data = cursor.fetchone()
	connection.close()
	if data is None:						# Checks if request identified by l_id exists or not
		messages.error(request, 'Leave request with given ID does not exist.')
		return HttpResponseRedirect(reverse('admin_dashboard'))
	cursor = connection.cursor()

	# Fetches no. of days of leave type l_id left for the faculty member who requested l_id
	cursor.execute("SELECT no_days_left from days_left where faculty_id='"+data[3]+"' and leave_type='"+data[4]+"';")
	days = cursor.fetchone()
	if request.POST:
		remarks = request.POST['remarks']
		status = request.POST['status']+'d'
		cursor = connection.cursor()
		try:
			# Insert into the reviewed requests table from the unreviewed requests
			cursor.execute("INSERT into leave_checked values("+str(data[0])+", '"+data[1].isoformat()+"', '"+data[2].isoformat()+"', '"
				+status+"', '"+remarks+"', '"+request.user.username+"', '"+data[3]+"', '"+data[4]+"');")
			
			# Deletes the record from the unreviewed requests table
			cursor.execute("DELETE from leave_request where leave_id='"+l_id+"';")

			if status=='Approved' and days is not None:
				# If the request is approved, then subtract the days of the request from the days left of that particular leave type
				if days[0]>=((data[2]-data[1]).days+1):
					cursor.execute("UPDATE days_left SET no_days_left="+str(days[0]-((data[2]-data[1]).days)+1)+" where faculty_id='"+data[3]+"' and leave_type='"+data[4]+"';")
				else:
					cursor.execute("UPDATE days_left SET no_days_left=0 where faculty_id='"+data[3]+"' and leave_type='"+data[4]+"';")
			connection.commit()
		except Exception as e:
			print e
			connection.rollback()
		connection.close()
		messages.success(request, 'Leave request successfully reviewed.')
		return HttpResponseRedirect(reverse('admin_dashboard'))

	# Fetches the details of the request under review
	cursor = connection.cursor()
	cursor.execute("SELECT leave_id, start_date, end_date, leave_type, faculty_id from leave_request where leave_id="+l_id+";")
	data = cursor.fetchone()
	connection.close()
	context = {'l_id': l_id, 'data': data}
	if days is not None:
		context['days'] = days[0]
	else:
		context['days'] = '-'
	return render(request, 'review.html', context)


# View for the admin to update the maximum days for the lapsable as well as non-lapsable leave types for all the users
# This operation is to be performed at the beginning of the academic year
def update_max_days(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if not request.user.is_staff:
		return HttpResponseRedirect(reverse('dashboard'))
	if request.POST:
		cursor = connection.cursor()
		try:
			# If the leave is non-lapsable add the remaining days left to max days for the next year
			cursor.execute("UPDATE days_left d, leave_info l SET d.no_days_left = d.no_days_left + l.max_days where d.leave_type=l.leave_type and l.lapsable='N';")
			# If the leave is lapsable discard the remaining days left
			cursor.execute("UPDATE days_left d, leave_info l set d.no_days_left = l.max_days where d.leave_type=l.leave_type and l.lapsable='Y';")
			connection.commit()
		except Exception as e:
			print e
			connection.rollback()
		connection.close()
		messages.success(request, 'Maximum days successfully deleted.')
		return HttpResponseRedirect(reverse('admin_dashboard'))
	return render(request, 'update_max_days.html')


# View for the admin to add a new faculty member
def add_faculty(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect(reverse('login'))
	if not request.user.is_staff:
		return HttpResponseRedirect(reverse('dashboard'))

	if request.POST:
		f_id = request.POST['f_id']							# Fetch the values entered by the admin in the registration form
		f_name = request.POST['f_name']
		m_name = request.POST['m_name']
		l_name = request.POST['l_name']
		dept = request.POST['dept']
		email = request.POST['email']
		pass1 = request.POST['pass1']
		pass2 = request.POST['pass2']
		desig = request.POST['desig']
		gender = request.POST['gender']

		match = re.search(r'[\w.-]+@[\w-]+\.[\w.-]+', email)
		cursor = connection.cursor()
		cursor.execute("SELECT * from faculty_member where faculty_id='"+f_id+"';")			# Check if faculty member with f_id already exists
		data = cursor.fetchone()
		cursor.execute("SELECT * from department where dept_id='"+dept+"';")				# Check if department 'dept' exists or not
		data1 = cursor.fetchone()
		connection.close()
		if data is not None:												# Check if proper values are entered by the admin
			messages.error(request, 'Faculty ID already registered')
		elif data1 is None:
			messages.error(request, 'Department does not exist.')
		elif pass1 != pass2:
			messages.error(request, 'Passwords do not match.')
		elif not match:
			messages.error(request, 'Invalid Email ID.')
		elif f_id == '':
			messages.error(request, 'Faculty ID cannot be left blank.')
		elif f_name == '':
			messages.error(request, 'First name cannot be left blank.')
		elif pass1 == '':
			messages.error(request, 'Password cannot be left blank.')
		else:
			cursor = connection.cursor()
			try:
				# If all constraints are satisfied, insert the record into the faculty_member table
				cursor.execute("INSERT into faculty_member values('"+f_id+"','"+pass1+"','"+dept+"','"+f_name+"','"+m_name
					+"','"+l_name+"','"+desig+"','"+gender+"','"+email+"');")

				# Create a new auth_user for the faculty member
				user = User.objects.create_user(f_id, None, pass1)

				# Generate the days left for all applicable leave types
				cursor.execute("SELECT leave_type, max_days, gender_spec from leave_info;")
				data = cursor.fetchall()
				for a in data:
					if a[2]=='All' or a[2][0]==gender[0]:
						cursor.execute("INSERT into days_left values('"+f_id+"','"+a[0]+"','"+str(a[1])+"');")
				connection.commit()
				messages.success(request, 'Faculty successfully registered.')
			except Exception as e:
				print e
				connection.rollback()
			connection.close()
			return HttpResponseRedirect(reverse('admin_dashboard'))

	return render(request, 'register.html')


# View for the logged-in user to log out
def logout(request):
	if request.user.is_authenticated():
		auth.logout(request)
		messages.success(request, 'Successfully logged out.')
	return HttpResponseRedirect(reverse('login'))