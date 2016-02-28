from .. import db
import datetime

class WaitTime(db.Model):
    __tablename__ = 'waittime'
    id = db.Column(db.Integer, primary_key=True)
    elapsed = db.Column(db.Integer)
    start_time = db.Column(db.DateTime)
    end_time = db.Column(db.DateTime)
    finished = db.Column(db.Boolean)
    pollingbooth_id = db.Column(db.Integer, db.ForeignKey('pollingbooth.id'))
    person = db.Column(db.Integer, db.ForeignKey('users.id'))


    def __init__(self):
        self.start_time = datetime.datetime.now()
        finished = False

    def finished(self):
        self.end_time = datetime.datetime.now()
        finished = True

        diff = self.end_time - self.start_time
        self.elapsed = divmod(diff.days * 86400 + diff.seconds, 60)[0]