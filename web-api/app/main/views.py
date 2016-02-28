from . import main
from flask.ext.login import login_required, current_user, login_user, logout_user
from flask import request, jsonify
import re
from ..models import User, WaitTime, PollingBooth
import json
import datetime




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


"""
ROUTES

Return format: {"code": X, "data": Y}

---------------------
X - 0, 1, 2
0: all is well
1: user does not exist (redirect to create account)
2: other error

"""

@main.route('/')
def index():
    return jsonify({"code": 0, "data": "Running"})


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
            return jsonify({"code": 0, "data": "Logged in %s." % first_name})

        else:
            return jsonify({"code": 2, "data": "User exists."})


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

        return jsonify({"code": 0, "data": elapsed_sum/count})

    else:
        return jsonify({"code": 2, "data": "Polling booth does not exist."})


@main.route('/start_time/<phone>', methods=['GET', 'POST'])
def start_time(phone):

    """
    Start wait time timer for user.

    Keyword arguments:
    phone -- phone number of user (10 digit)

    """

    user = User.query.filter_by(phone=phone_format(phone)).first()

    if user == None:
        return jsonify({"code": 1, "data": "User account does not exist."})

    if user.waittime == None:
        wait_time = WaitTime()
        user.waittime = wait_time
        db.session.add(wait_time)
        db.session.commit()
        return jsonify({"code": 0, "data": "Wait time started."})
    else:
        return jsonify({"code": 2, "data": "Wait time already exists."})


@main.route('/end_time/<phone>', methods=['GET', 'POST'])
def end_time(phone):

    """
    End wait time timer for user.

    Keyword arguments:
    phone -- phone number of user (10 digit)

    """

    user = User.query.filter_by(phone=phone_format(phone)).first()

    if user == None:
        return jsonify({"code": 1, "data": "User account does not exist."})

    if user.waittime:
        wait_time = user.waittime
        wait_time.finished()
        return jsonify({"code": 0, "data": "Wait time ended."})
    else:
        return jsonify({"code": 2, "data": "Wait time doesn't exist."})


@main.route('/polling_places')
def polling_places():

    """
    Get all polling places.

    """

    polling_places = PollingBooth.query.all()
    return jsonify([(x.id, x.name, x.address, x.zip_code) for x in polling_places])



