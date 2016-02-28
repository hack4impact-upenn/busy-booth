from .. import db
import datetime


class PollingBooth(db.Model):
    __tablename__ = 'pollingbooth'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    address = db.Column(db.String(64))
    zip_code = db.Column(db.Integer)
    avg_wait = db.Column(db.Integer)
    people = db.relationship('User', backref='pollingbooth', lazy='dynamic')
    wait_times = db.relationship('WaitTime', backref='pollingbooth', lazy='dynamic')

    def __init__(self, name, address, zip_code):
        self.name = name
        self.address = address
        self.zip_code

    # how to calculate average wait time?
