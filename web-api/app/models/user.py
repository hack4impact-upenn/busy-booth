from .. import db

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    hashVal = db.Column(db.String(64), index=True)
    polling_booth = db.Column(db.Integer, db.ForeignKey('pollingbooth.id'))
    waittime = db.relationship('WaitTime', uselist=False, backref='users')

    def __init__(self, hashVal):
        self.hashVal = hashVal

    def __repr__(self):
        return '<User \'%s\'>' % self.hashVal

    def overview(self):
        return {
            "code": 0,
            "hashVal": self.hashVal,
            "booth_id": self.polling_booth.id
        }
