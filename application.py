import logging

from flask import Flask, jsonify

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")

application = Flask(__name__)


@application.route("/")
def hello_world():
    logging.info("hello_world called")

    return "Hello, World!"


@application.route("/api/<value>")
def sample_api(value):
    logging.info("sample_api called")

    try:
        results = add_one(int(value))
        return jsonify(results), 200
    except Exception as e:
        msg = f"Caught exception when calculating results: {e}"
        logging.exception(msg)
        return msg, 500


@application.route("/health")
def health_check():
    return "ok", 200


def add_one(value: int) -> dict:
    if value == 10:
        raise ValueError("Invalid value!")

    return {"success": True, "answer": value + 1}


if __name__ == "__main__":
    application.run(debug=True)
