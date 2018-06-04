#!/bin/env bash

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

curl -H "Content-Type: application/json" -X POST -d '{"from":"sebastiaan@sevaho.io", "to":"sebastiaan@sevaho.io", "message": "hell yeah", "code":"test"}' http://localhost:8000/sendmail
