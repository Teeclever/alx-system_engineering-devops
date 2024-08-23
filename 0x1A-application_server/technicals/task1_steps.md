# Task 0 steps

- ssh into your web server

  - ssh ubuntu@your-web-server-ip

- Install the net-tools package on your server by running the command:

  - sudo apt install -y net-tools

- Git clone your AirBnB_clone_v2 on your web-01 server:

  - git clone https://github.com/your-username/AirBnB_clone_v2.git

- Navigate to the web_flask directory:

  - cd AirBnB_clone_v2/web_flask

- Modify the 0-hello_route.py script to serve its content from the route /airbnb-onepage/ on port 5000. Update the file as follows:

  @app.route('/airbnb-onepage/', strict_slashes=False)
  def hello_hbnb():
  """Function called through the /airbnb-onepage/ route."""
  return 'Hello HBNB!'

  if **name** == '**main**':
  app.run(host='0.0.0.0', port=5000)

- Save the changes and run your Flask application:

  - python3 -m web_flask.0-hello_route

- Verify the configuration using curl: (on another window)
  - curl 127.0.0.1:5000/airbnb-onepage/

Ran into some `port-connection in use` errors while trying to run the examples. Remembered that the datadog agents we set up in a previous project is using the port 5000.

So I had to go into the datadog config file to edit out the port.
`cd /etc/datadog-agent/`

![app-server1](./technicals/app-server1.JPG)

`sudo vi datadog.yaml`

In the config file, it's mostly commented. We look for the `Advanced Configuration` Section

![app-server1](./technicals/app-server2.JPG)

Change the `expvar_port` to any other figure to free up the 5000 and enable it for binding

![app-server1](./technicals/app-server3.JPG)

After that, we need to restart our datadog-agent

  - `sudo service datadog-agent restart`

Final result, if all is done well.

![app-server1](./technicals/app-server4.JPG)

## Task 1 steps

- In the server, install gunicorn and any other libraries required by our application

  - `pip3 install gunicorn`

- Confirm that your Flask application object is named app in the `0-hello_route.py` script.

- Run Gunicorn to bind to 0.0.0.0 on port 5000 with your application object as the entry point:

  - `gunicorn --bind 0.0.0.0:5000 web_flask.0-hello_route:app`

- In a different terminal, verify that it's working by using curl:
  - `curl 127.0.0.1:5000/airbnb-onepage/`
