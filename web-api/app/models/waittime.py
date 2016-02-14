from .. import db
import datetime

class WaitTime(db.Model):
    __tablename__ = 'waittime'
    id = db.Column(db.Integer, primary_key=True)
    person = db.relationship('Person', backref='waittime', lazy='dynamic')
    elapsed = db.Column(db.Integer)
    start_time = db.Column(db.DateTime)
    end_time = db.Column(db.DateTime)
    finished = db.Column(db.Boolean)


    def __init__(self, person):
        self.start_time = datetime.datetime.now()
        self.person = person
        finished = False

    def finished(self):
        self.end_time = datetime.datetime.now()
        finished = True

        diff = self.end_time - self.start_time
        self.elapsed = divmod(diff.days * 86400 + diff.seconds, 60)[0]