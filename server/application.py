from os import walk

from flask import json


def fetch_data(url):
    data = []
    files = [x for x in walk(url)][0][2]
    # print(files)
    for session in files:
        data.append(read_file(f"{url}/{session}"))
        # print(read_file(session))

    return data


def read_file(filename):
    print(f'Reading file: {filename}')
    with open(filename, 'r', encoding='utf-8') as file:
        res = json.load(file)
        return res


def save_data(my_json, filename):
    json.dump(my_json, filename)
    return '* SUCCESSFULLY UPLOADED'
