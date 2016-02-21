from . import main


@main.route('/')
def index():
    return "HELLO"


@main.route('/login')
def login():
	return

@main.route('/logout')
def logout():
	return

@main.route('/signup')
def signup():
	return

@main.route('/av_wait')
def av_wait():
	return


@main.route('/start_time')
def start_time():
	return


@main.route('/end_time')
def end_time():
	return


@main.route('/polling_places')
def polling_places():
	return