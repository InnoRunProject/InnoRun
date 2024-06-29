from flask import Flask

from CONST.CONSTANTS import *
from application import fetch_data, save_data
import datetime

app = Flask(__name__)


@app.route('/', methods=['GET'])
def base():
    json_data = fetch_data(BASE_SESSIONS_URL);
    # json_data = [{'owner': 'dima',
    #               'route': 'route',
    #               'members': ['user1', 'user2', 'user3'],
    #               'date': '29.06.24 9:00:00'}, {}]

    return json_data


@app.route('/upload', methods=['POST'])
def upload():
    datetime.date.today()
    save_data('request.json',
              BASE_SESSIONS_URL +
              '/session-' +
              datetime.date.today().strftime('%D.%M.%Y') +
              '.json')
    return 'Data uploaded successfully'


def main():
    # db_session.global_init("../server/database/db.db")
    app.run(host="localhost", port=5000, debug=True)
