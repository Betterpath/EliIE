import random
import os
import string
from flask import Flask, request, Response
from flask_basicauth import BasicAuth


app = Flask(__name__)

app.config['BASIC_AUTH_USERNAME'] = os.getenv('FLASK_USER')
app.config['BASIC_AUTH_PASSWORD'] = os.getenv('FLASK_SECRET')

basic_auth = BasicAuth(app)


@app.route('/eliie', methods=['POST'])
@basic_auth.required
def parse():
    file_name = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10))
    input_dir = '/code/output'
    output_dir = '/code/output'

    try:
        data = request.form['data']
    except Exception as e:
        return 'Error'

    handle = open(output_dir + '/' + file_name + '.txt', 'w+')
    handle.write(data)
    handle.close()

    os.system('python NamedEntityRecognition.py ' + input_dir + ' ' + file_name + '.txt' + ' ' + output_dir)
    os.system('python Relation.py ' + output_dir + ' ' + file_name + '.txt')

    handle = open(output_dir + '/' + file_name + '_Parsed.xml', 'r')
    xml = handle.read()
    handle.close()

    os.remove(output_dir + '/' + file_name + '.txt')
    os.remove(output_dir + '/' + file_name + '_NER.xml')
    os.remove(output_dir + '/' + file_name + '_Parsed.xml')

    return Response(xml, mimetype='text/xml')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
