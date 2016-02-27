from . import main

from flask.ext.login import login_required, current_user, login_user, logout_user
from flask import request
import re
from ..models import User


@main.route('/')
def index():
    return "HELLO"

@main.route('/loggedin')
# @login_required
def loggedin():
	if current_user.is_authenticated():
   		print current_user.id
   	else:
   		print "AAAAAA"
	return "LOGGED IN"


def phone_format(number):
    digits = re.sub(r'\D', '', number)
    if len(digits) == 10:
        digits = '1' + digits
    digits = '+' + digits
    return digits


@main.route('/login', methods=['GET', 'POST'])
def login():
	print "in route"
	if request.method == "POST":


		phone = phone_format(request.form['phone'])

		print phone


		user = User.query.filter_by(phone=phone).first()

		# if user is not None and user.verify_password(request.form['password']):

		if user is not None:
			login_user(user)
			return "Logged in"

	return "Failed logged in"


@main.route('/logout', methods=['GET', 'POST'])
@login_required
def logout():
	logout_user()
	return True


@main.route('/signup', methods=['GET', 'POST'])
def signup():

	print "SIGNING UP "

	if request.method == "POST":
		first_name = request.form['fname']
    	last_name = request.form['lname']
    	phone = phone_format(request.form['phone'])
    	address = request.form['address']
    	# polling_booth = 

    	return True

	return False



@main.route('/av_wait')
def av_wait():
	return "AV_WAIT"


@main.route('/start_time', methods=['GET', 'POST'])
@login_required
def start_time():
	return "START TIME"


@main.route('/end_time', methods=['GET', 'POST'])
@login_required
def end_time():
	return "END TIME"


@main.route('/polling_places')
def polling_places():
	return "PLACES"



