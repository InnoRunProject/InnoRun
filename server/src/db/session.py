import datetime
import sqlite3

import sqlalchemy
from werkzeug.security import generate_password_hash, check_password_hash

from db_session import SqlAlchemyBase


class RunSession(SqlAlchemyBase):
    __tablename__ = 'sessions'

    id = sqlalchemy.Column(sqlalchemy.Integer,
                           primary_key=True, autoincrement=True)
    owner = sqlalchemy.Column(sqlalchemy.String, nullable=False)
    date = sqlalchemy.Column(sqlalchemy.DateTime, nullable=False)
    route = sqlalchemy.Column(sqlalchemy.ARRAY, nullable=True)
    members = sqlalchemy.Column(sqlalchemy.ARRAY, nullable=False)

    def set_owner(self, owner):
        self.owner = owner

    def save_session(self):
        con = sqlite3.connect(f"server/database/db.db")
        cur = con.cursor()
        cur.execute(f"INSERT INTO sessions ({owner}, {date}, {route}, {members}) VALUES (?, ?, ?, ?)",
                    (self.owner, self.date, self.route, self.members))
        con.commit()
        con.close()


class Session:
    def __init__(self, owner, members, time, route):
        self.owner = owner
        self.members = members
        self.time = time
        self.route = route

    def __str__(self):
        return f"Session({self.owner}, {self.members}, {self.time}, {self.route})"

    def to_json(self):
        return {
            "owner": self.owner,
            "members": self.members,
            "time": self.time,
            "route": self.route
        }

    @staticmethod
    def from_json(json):
        return Session(json["owner"], json["members"], json["time"], json["route"])

    def add_member(self, member):
        self.members.append(member)
