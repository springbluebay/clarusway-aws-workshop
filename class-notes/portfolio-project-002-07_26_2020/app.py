from flask import Flask, render_template, request

app = Flask(__name__)

def convert(milliseconds):
    hour_in_milliseconds = 60*60*1000
    hours = milliseconds // hour_in_milliseconds
    milliseconds_left = milliseconds % hour_in_milliseconds
    
    minute_in_milliseconds = 60*1000
    minutes = milliseconds_left // minute_in_milliseconds
    # milliseconds_left = milliseconds_left % minute_in_milliseconds
    milliseconds_left %= minute_in_milliseconds
    
    seconds = milliseconds_left // 1000

    return f'{hours} hour/s'*(hours!=0) + f' {minutes} minute/s'*(minutes!=0)+ f' {seconds} second/s'*(seconds!=0) or f'just {milliseconds} millisecond/s'

@app.route('/', methods=['GET'])
def main_get():
    return render_template('index.html', not_valid=False, developer_name='Callahan')

@app.route('/', methods=['POST'])
def main_post():
    alpha = request.form['number']
    if not alpha.isdecimal():
        return render_template('index.html', not_valid=True, developer_name='Callahan')
    number=int(alpha)
    if not (0 < number):
        return render_template('index.html', not_valid=True, developer_name='Callahan')
    return render_template('result.html', milliseconds=number, result=convert(number), developer_name='Callhan')

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(host='0.0.0.0', port=80)
