from . import main
from flask.ext.login import login_required, current_user, login_user, logout_user
from flask import request
import re
from ..models import User, WaitTime, PollingBooth
import json
import datetime


@main.route('/')
def index():
    return "Running."


# Testing URL - ignore
@main.route('/loggedin')
def loggedin():
    if current_user.is_authenticated():
        print current_user.id
        return "Logged in."
    else:
        return "Not logged in."

 
def phone_format(number):

    """
    Format an integer into a phone number.

    Keyword arguments:
    number -- 10 digit integer

    """

    digits = re.sub(r'\D', '', number)
    if len(digits) == 10:
        digits = '1' + digits
    digits = '+' + digits
    return digits


@main.route('/create_account', methods=['GET', 'POST'])
def create_account():

    """
    Create new user.

    """

    if request.method == "POST":

        first_name = request.form['fname']
        last_name = request.form['lname']
        phone = phone_format(request.form['phone'])
        address = request.form['address']

        if User.query.filter_by(phone=phone).first() == None:
            new_user = User(
                first_name = first_name,
                last_name = last_name,
                phone = phone,
                address = address
                )

            # How to set polling booth?

            db.session.add(new_user)
            db.session.commit()
            return "Logged in %s." % first_name



        else:
            return "User exists."


@main.route('/av_wait/<int:booth_id>')
def av_wait(booth_id):

    """
    Get average wait time for a polling booth.

    Keyword arguments:
    booth_id -- integer id of polling booth

    """

    polling_place = PollingBooth.query.filter_by(id=booth_id).first()

    if polling_place:

        past_hour = datetime.datetime.now() - datetime.timedelta(hours=1)

        # get wait times in past hour
        count = 0.0
        elapsed_sum = 0
        for time in polling_place.wait_times:
            if time.start_time > past_hour and time.finished:
                count += 1.0
                elapsed_sum += time.elapsed

        return json.dumps(elapsed_sum/count)

    else:
        return "Polling booth does not exist."




@main.route('/start_time/<phone>', methods=['GET', 'POST'])
def start_time(phone):

    """
    Start wait time timer for user.

    Keyword arguments:
    phone -- phone number of user (10 digit)

    """

    user = User.query.filter_by(phone=phone_format(phone)).first()

    if user == None:
        return "User account does not exist"

    if user.waittime == None:
        wait_time = WaitTime()
        user.waittime = wait_time
        db.session.add(wait_time)
        db.session.commit()
        return "Wait time started."
    else:
        return "Wait time already exists."


@main.route('/end_time/<phone>', methods=['GET', 'POST'])
def end_time(phone):

    """
    End wait time timer for user.

    Keyword arguments:
    phone -- phone number of user (10 digit)

    """

    user = User.query.filter_by(phone=phone_format(phone)).first()

    if user == None:
        return "User account does not exist"

    if user.waittime:
        wait_time = user.waittime
        wait_time.finished()
        return "Wait time ended."
    else:
        return "Wait time doesn't exist."



@main.route('/polling_places')
def polling_places():

    """
    Get all polling places.

    """
    
    polling_places = PollingBooth.query.all()
    return json.dumps([(x.id, x.name, x.address, x.zip_code) for x in polling_places])



