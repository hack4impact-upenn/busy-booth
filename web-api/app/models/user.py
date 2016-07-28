from .. import db

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    hashVal = db.Column(db.String(64), index=True)
    polling_booth = db.Column(db.Integer, db.ForeignKey('pollingbooth.id'))
    waittime = db.relationship('WaitTime', uselist=False, backref='users')

    def __init__(self, hashVal, polling_booth):
        self.hashVal = hashVal
        self.polling_booth = polling_booth

    def overview(self):
        return {
            "code": 0,
            "hashVal": self.hashVal,
            "booth_id": self.polling_booth.id
        }
