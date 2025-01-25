from flask import Flask, request, jsonify
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''  # Replace with your MySQL password
app.config['MYSQL_DB'] = 'digitalbharat'

mysql = MySQL(app)

@app.route('/api', methods=['GET'])
def handle_data():
    # Get parameters from the Flutter request
    enroll = request.args.get('enroll')
    phone = request.args.get('phone')

    if not enroll or not phone:
        return jsonify({"message": "Enrollment number and phone number are required"}), 400

    try:
        # Connect to the database
        cur = mysql.connection.cursor()
        
        # Check if enrollment and phone match
        query = """
        SELECT id, name, enrollment, phone, email, institute, created_date, updated_date
        FROM studentdb
        WHERE enrollment = %s AND phone = %s
        """
        cur.execute(query, (enroll, phone))
        result = cur.fetchone()
        cur.close()

        if result:
            # Map result fields to dictionary keys
            keys = ["id", "name", "enrollment", "phone", "email", "institute", "created_date", "updated_date"]
            data = dict(zip(keys, result))

            # Return data to the Flutter app
            return jsonify(data), 200
        else:
            # If no matching record is found
            return jsonify({"message": "Incorrect credentials"}), 401

    except Exception as e:
        return jsonify({"message": f"An error occurred: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(debug=True)
