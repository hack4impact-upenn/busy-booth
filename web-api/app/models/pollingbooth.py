from .. import db
import datetime


wait_times = db.Table('wait_times',
    db.Column('pollingbooth_id', db.Integer, db.ForeignKey('pollingbooth.id'), nullable=False),
    db.Column('waittime_id', db.Integer, db.ForeignKey('waittime.id'), nullable=False),
    db.PrimaryKeyConstraint('pollingbooth_id', 'waittime_id')
)

class PollingBooth(db.Model):
    __tablename__ = 'pollingbooth'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    address = db.Column(db.String(64))
    zip_code = db.Column(db.Integer)
    wait_times = db.relationship('WaitTime',
                                    secondary=wait_times, 
                                    primaryjoin=(wait_times.c.pollingbooth_id==id),
                                    backref=db.backref('polingbooth'))
    avg_wait = db.Column(db.Integer)

    def __init__(self, name, address, zip_code):
        self.name = name
        self.address = address
        self.zip_code

    # how to calculate average wait time?
