from flask import Blueprint, jsonify

api = Blueprint("api", __name__)

@api.route("/")
def home():
    return "Flask backend is running!"

@api.route("/health")
def health():
    return jsonify(status="UP")

@api.route("/message")
def message():
    return jsonify(message="Hello from Flask backend")

