from .. import db
import datetime


class PollingBooth(db.Model):
    __tablename__ = 'pollingbooth'
    id = db.Column(db.Integer, primary_key=True)
    address = db.Column(db.String(64))
    zip_code = db.Column(db.Integer)
    people = db.relationship('User', backref='pollingbooth', lazy='dynamic')
    wait_times = db.relationship('WaitTime', backref='pollingidbooth', lazy='dynamic')

    def __init__(self, address, zip_code):
        self.address = address
        self.zip_code = zip_code
