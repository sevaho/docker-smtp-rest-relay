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

from flask import Flask
import sys
import logging
from dotenv import load_dotenv
from pathlib import Path  # python3 only

app = Flask(__name__)

app.logger.addHandler(logging.StreamHandler(sys.stdout))
app.logger.setLevel(logging.DEBUG)

env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)

import routes
