from .. import db

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    hashVal = db.Column(db.String(64), index=True)
    polling_booth = db.Column(db.Integer, db.ForeignKey('pollingbooth.id'))
    waittime = db.relationship('WaitTime', uselist=False, backref='users')

    # first_name = db.Column(db.String(64), index=True)
    # last_name = db.Column(db.String(64), index=True)
    # phone = db.Column(db.String(16), unique=True)
    # address = db.Column(db.String(128), index=True)

    # def __init__(self, first_name, last_name, phone, address):
    #     self.first_name = first_name
    #     self.last_name = last_name
    #     self.phone = phone
    #     self.address = address

    def __init__(self, hashVal):
        self.hashVal = hashVal

    # def full_name(self):
    #     return '%s %s' % (self.first_name, self.last_name)

    def __repr__(self):
        return '<User \'%s\'>' % self.hashVal

    def overview(self):
        return {
            "code": 0,
            # "first_name": self.first_name,
            # "last_name": self.last_name,
            # "full_name": self.full_name(),
            # "address": self.address,
            "hashVal": self.hashVal,
            "booth_id": self.polling_booth.id
        }
