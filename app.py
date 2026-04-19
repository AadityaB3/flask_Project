from flask import Flask
import os
import pymysql

app = Flask(__name__)

def get_connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST','mysql-service'),
        user=os.getenv('DB_USER','root'),
        password=os.getenv('DB_PASS','password'),
        database=os.getenv('DB_NAME','testdb')
    )

@app.route('/')
def home():
    return 'Flask App Running with MySQL on Kubernetes'

@app.route('/health')
def health():
    return {'status':'ok'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)