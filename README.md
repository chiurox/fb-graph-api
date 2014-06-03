# Graph API Test application

This is a small Rails demo application where a user can query all public Facebook posts
by first connecting via Facebook, then specifying some keyword or phrase and a start and end date.
Basic steps to clone and get it up an running locally:

    $ git clone git@github.com:chiurox/fb-graph-api.git
    $ cd fb-graph-api
    $ bundle install

This app uses Facebook Javascript SDK to get an Access Token. First, you need to add an entry to
the /etc/hosts in order to work with Facebook' OAuth.
    $ sudo vi /etc/hosts
    $ Password: [your password]

Add the following to the beginning of the file and save it:

    127.0.0.1       fb-graph-api.test

Run the server locally:

    $ rails s

Access it in the browser via the following domain and port:

    http://fb-graph-api.test:3000/


The Facebook Graph API call to "/search" is deprecated in v2.0, only accessible in v1.0.
In order to make this request to "/search", the provided Access Token has to be from a Facebook App
that has been created before April 30th, 2014. So I'm using the Facebook App ID and secret from an old
Facebook app I had.

    Name: GraphApiTest
    Facebook App ID: 442757099074908
    App Secret: 170c0265ec86615e855f9dd48f3c561e
