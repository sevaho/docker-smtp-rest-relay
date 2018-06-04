#! /usr/bin/python

# -----------------------------------------------------------------------------------------------------------------------------
# GENERAL
# -----------------------------------------------------------------------------------------------------------------------------
#
# author: Sebastiaan Van Hoecke
# mail: sebastiaan@sevaho.io
#
# NOTE:
#
# -----------------------------------------------------------------------------------------------------------------------------

from flask import request, abort
from app import app
import mail

# -----------------------------------------------------------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------------------------------------------------------


# -----------------------------------------------------------------------------------------------------------------------------
# MAIN
# -----------------------------------------------------------------------------------------------------------------------------


@app.route('/')
@app.route('/index')
def index ():
    return "test"


@app.route('/sendmail', methods=['POST'])
def sendmail ():
    mail_from = ""
    mail_to = ""
    message = ""
    code = ""
    if not request.json:
        abort(400)

    if 'from' in request.json:
        mail_from = request.json['from']
    if 'to' in request.json:
        mail_to = request.json['to']
    if 'message' in request.json:
        message = request.json['message']
    if 'code' in request.json:
        code = request.json['code']

    if mail_from != "" and mail_to != "" and message != "" and code != "":
        if mail.checkcode(code):
            return mail.sendmail(mail_from, mail_to, message)
        else:
            return "code is wrong"
    else:
        return "values are empty"
