
import firebase_admin
import sys
from firebase_admin import credentials, messaging
import requests

firebase_cred = credentials.Certificate("firebase.json")
firebase_app = firebase_admin.initialize_app(firebase_cred)

message = ''
title = ''
topic = ''


def send_topic_push(title, body, topic):
    message = messaging.Message(
        data={
            'title': title,
            'body': body,
        },
        topic=topic
    )
    messaging.send(message)


if len(sys.argv) > 3:
    title = sys.argv[1]
    message = sys.argv[2]
    topic = sys.argv[3]
    print(title, message, topic)
    send_topic_push(title, message, topic)
