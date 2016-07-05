from . import main
from flask import request, jsonify, redirect, url_for, Flask, send_from_directory, flash, render_template
import re
from ..models import User, WaitTime, PollingBooth
import json
import datetime
from ..import db
import urllib2
import os
import csv
import hashlib


"""
ROUTES

Return format: {"code": X, "data": Y}

---------------------
X - 0, 1
0: all is well
1: error

"""

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] == 'csv'

@main.route('/', methods=['GET', 'POST'])
def read_file():

    """
    Reads the uploaded documents and stores the hashes in our database.

    """
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            flash('Reading File...')
            process_file(file)
            return render_template('done.html')
        else:
            flash('Invalid file type')
    return render_template('main.html')

def process_file(file):
    reader = csv.DictReader(file)
    for line in reader:
        street_number = line['Address'].split()[0]
        stringToHash = line['First Name']+line['Last Name']+line['DOB']+street_number
        hashVal = hashlib.sha256(stringToHash).hexdigest()

        if User.query.filter_by(hashVal=hashVal).first() == None:
            new_user = User(
                hashVal = hashVal
            )

            # # How to set polling booth? TO DO. CANNOT BE HARD CODED.
            # PollingBooth.query.filter_by(id=1).first().people.append(new_user)

            db.session.add(new_user)
            db.session.commit()
    



@main.route('/validate_user', methods=['GET', 'POST'])
def validate_user():

    """
    Create new user.

    """

    if request.method == "POST":
        hashVal = request.form['hashVal']
        if User.query.filter_by(hashVal=hashVal).first() == None:
            return jsonify({"code": 1, "data": "Cannot find individual"})
        else:
            return jsonify({"code": 0, "data": "Logged in."})

# @main.route('/get_polling_booth/<address>')
# def get_polling_booth(address):

#     key = "AIzaSyBQB5ELmm4MbpQUJLT3xR9rfyhYFEksgvc"
#     url = "https://www.googleapis.com/civicinfo/v2/voterinfo?address={}&fields=pollingLocations&key={}".format(address, key)

#     html = urllib2.urlopen(url).read()
#     if html == "{}":
#         return False
#     else:
        

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

        if (count != 0.0):
            return jsonify({"code": 0, "data": elapsed_sum/count})
        else:
            return jsonify({"code": 2, "data": "Insufficient data."})

    else:
        return jsonify({"code": 2, "data": "Polling booth does not exist."})


@main.route('/history_wait/<int:booth_id>')
def history_wait(booth_id):

    """
    Get list of hourly average wait times for a polling booth (6 hours).

    Keyword arguments:
    booth_id -- integer id of polling booth

    """

    polling_place = PollingBooth.query.filter_by(id=booth_id).first()

    if polling_place:

        # calculate start of hourly increments of time
        now = datetime.datetime.now().replace(minute=0, second=0, microsecond=0)
        past_hours = []
        for i in xrange(6):
            past_hours.append(now - datetime.timedelta(hours=i+1))

        # get hourly wait time averages of past six hours
        counts = [0.0]*6
        elapsed_sums = [0]*6

        for time in polling_place.wait_times:
            if time.finished:
                if time.start_time > now:
                    pass
                else:
                    for i in xrange(6):
                        if time.start_time > past_hours[i]:
                            counts[i] += 1
                            elapsed_sums[i] += time.elapsed
                            break

        averages = []
        for i in xrange(6):
            minute_start = past_hours[i].hour * 60 + past_hours[i].minute

            # if no data for that hour set average as -1
            if counts[i] == 0.0:
                averages.append({"hour_start": past_hours[i], "minute_start": minute_start, "time":-1})
            else:
                averages.append({"hour_start": past_hours[i], "minute_start": minute_start, "time":elapsed_sums[i]/counts[i]})

        return jsonify({"code": 0, "data": averages})

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

        polling_place = PollingBooth.query.filter_by(id=user.polling_booth).first()
        polling_place.wait_times.append(wait_time)

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
    return jsonify({"code": 0, "data":[{"id":x.id, "name":x.name, "address":x.address, "zipcode":x.zip_code} for x in polling_places]})


@main.route('/lookup/<hashVal>', methods=['GET', 'POST'])
def lookup(hashVal):

    """
    Gets the users information from the hash

    Keyword arguments:
    hash -- hash of user

    """

    user = User.query.filter_by(hashVal=hashVal).first()

    if user == None:
        return jsonify({"code": 1, "data": "User account does not exist."})

    booth = PollingBooth.query.filter_by(id=user.polling_booth).first()

    return jsonify({"code": 0, "data": {"address": booth.address, 
                                            "zip": booth.zip_code}});

    
