from flask import Flask, jsonify
from datetime import datetime

request_count = 0

app = Flask(__name__)

@app.before_request
def count_requests():
    global request_count
    request_count += 1

@app.route('/')
def index():
    return jsonify({
        "app": "SRE Task API",
        "endpoints": ["/health", "/metrics"]
    })

@app.route('/health')
def health():
    return jsonify(status='ok', timestamp=datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ'))
  
@app.route('/metrics')
def metrics():
    metrics_data = {
        'requests': request_count
    }
    return jsonify(metrics_data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)

