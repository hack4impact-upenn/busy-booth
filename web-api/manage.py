#!/usr/bin/env python
import os
from app import create_app, db
from app.models import WaitTime, PollingBooth, User
from flask.ext.script import Manager, Shell
from flask.ext.migrate import Migrate, MigrateCommand
from config import TestingConfig
import time

# Import settings from .env file. Must define FLASK_CONFIG
if os.path.exists('.env'):
    print('Importing environment from .env file')
    for line in open('.env'):
        var = line.strip().split('=')
        if len(var) == 2:
            os.environ[var[0]] = var[1]

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manager = Manager(app)
migrate = Migrate(app, db)


def make_shell_context():
    return dict(app=app, db=db, User=User, Role=Role)


manager.add_command('shell', Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)


@manager.command
def test():
    """Run the unit tests."""
    import unittest

    tests = unittest.TestLoader().discover('tests')
    unittest.TextTestRunner(verbosity=2).run(tests)


@manager.command
def recreate_db():
    """
    Recreates a local database. You probably should not use this on
    production.
    """
    db.drop_all()
    db.create_all()
    db.session.commit()

    # setting up dummy data
    setup_initial_users()
    print "after initial"
    setup_waitingtimes()
    print "after waiting time"
    setup_polling_booths()
    print "after polling"


@manager.command
def setup_initial_users():

    tc = TestingConfig()


    user1 = User(
        first_name = "Cathy",
        last_name = "Chen",
        phone = "+19178213080",
        address = "4044 Sansom Street"
        )

    user2 = User(
        first_name = "Krishna",
        last_name = "Bharathala",
        phone = "+12159230239",
        address = "4056 Irving Street"
        )

    db.session.add(user1)
    db.session.add(user2)
    db.session.commit()


@manager.command
def setup_waitingtimes():

    print "inside waiting times"

    user1 = User.query.filter_by(first_name="Cathy").first()
    user2 = User.query.filter_by(first_name="Krishna").first()

    print "after user search"

    time1 = WaitTime()
    time2 = WaitTime()

    user1.waittime = time1
    user2.waittime = time2

    time.sleep(30)
    time1.finished()
    time.sleep(30)
    time2.finished()


    db.session.add(time1)
    db.session.add(time2)
    db.session.commit()

    


@manager.command
def setup_polling_booths():

    booth1 = PollingBooth(
        name = "Alex's Booth",
        address = "4044 Sansom Street",
        zip_code = 19104
        )

    user1 = User.query.filter_by(first_name="Cathy").first()
    user2 = User.query.filter_by(first_name="Krishna").first()
    booth1.people.append(user1)
    booth1.people.append(user2)

    times = WaitTime.query.all()
    booth1.wait_times.append(times[0])
    booth1.wait_times.append(times[1])

    db.session.add(booth1)
    db.session.commit()


if __name__ == '__main__':
    manager.run()
