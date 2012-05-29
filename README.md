bostonrb-examples
=================

This repo contains a stub of a Ruby On Rails application as well 
as some exercises for a beginner to attempt. By following the 
instructions on this page, you will see examples of:

- cloning into an existing code repository with git
- using rails helper functions to format the display of information
 on your web page
- writing methods on a Model to add function to your application
- use an external library, or gem, to interface with an outside
 service (in this case, Twitter)

Getting Started
---------------

You've just been approached by a friend with some Ruby code they
need help on. They're trying to make a website they can use to 
track donations they receive for the non-profit they started.  
They're almost there, but they need some help customizing the
site to a few requirements.  Can you help them?

__NOTE__: The following exercises assume you have already installed
ruby 1.9.3, rails 3.2.x, git, and heroku.  If that's not the case,
check out our installation guide __LINK OUT TO INSTALLATION GUIDE__.

###Cloning a Repository
First thing's first, you need to grab the existing code. In a
terminal, navigate to the directory that you want your application's
folder to be saved in.  As an example, for the author of this guide,
it would be ~/Work/Ruby.  Once in that terminal, use the following
command:

    git clone git://github.com/dylancashman/bostonrb-examples.git
    
Notice that the address in that command is the same address listed
at the top of the page.  This is a unique identifier of this code
repository to the git command.

That command should have resulted in the repository being downloaded
into a folder called 'bostonrb-examples' in whatever directory your
terminal was navigated to.  Navigate into the 'bostonrb-examples' 
folder and run the following commands:

    bundle
    rake db:migrate
    
The `bundle` command bundles all of the gem dependencies of the
application as defined in the Gemfile.  The next command, 
`rake db:migrate`, runs the database migrations within db/migrations.
In short, it creates a database with tables that your application
can store data into.

At this point, your local environment should be ready to run your
web application.  We're going to start up our local server, and then
direct our browser to look at that server.  In your terminal, type
`rails server`.  This command starts up a server, and dumps the
output into the terminal as you use the server.  In your favorite
browser, go to the address `localhost:3000`, as if it were a web 
address like http://www.google.com.  You should see the stub of an
application that collects information about donations.

###Populating data
The application looks functional, but before we can do much with it,
we'll need some data in it to see what it'll look like once it's
being used.  You can add in data manually by clicking around on the
site, or you can use the provided 'seeds' included in the application.

Use your text editor to look at the file `db/seeds.rb`.  This file
generally holds ruby code that fills in the database with test data.
In order to run that code, use the following command from project
directory in the terminal:

    rake db:seed
    
Now, when you load up the page again in your browser it should be
populated with some data.

Improving the Views
-------------------

The first request your friend has to improve this app is in displaying
currency.  The app looks good, but the numbers don't make as much of
an impact unless she can see some dollar signs.  To do this, we're
going to make use of a helper function.  With Rails, we can control
the display of our information, or the html that the user's browser
receives.  In other words, we can use a helper function that is
available in rails to display number fields as currency.  We'll be
using [#number_to_currency](http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#method-i-number_to_currency).
Looking at the documentation, it takes in a number as an argument 
and gives out a string that looks like currency.  So we'll need to 
call it in a view, each place where currency should be displayed.

Let's start on the index.  Open up app/views/donations/index.html.erb
in your text editor.  Try to figure out where in this view file the
donation's `amount` is displayed.  Call the #number_to_currency
on this value.  Reload your page and you should see the `amount`
fields displayed with in currency format: `$120.00`. As extra work, 
first try to find other locations in the application besides the 
index where currency should be displayed.  

While the method we used here was already present in Rails, you can
write your own helper methods in app/helpers/application_helper.rb.
Any method defined in the module in this file is available to be used
in your views, just like we used the #number_to_currency method.  

Let's try to define a method that capitalizes every word in a string,
to be used on the `from` field.  Within the application_helper.rb
file, we'll define a method:

    module ApplicationHelper
      def capitalize_each_word(uncapitalized_string)
        #your code goes here
      end
    end
    
Using the available methods for 
[Strings](http://corelib.rubyonrails.org/classes/String.html)
and [Arrays](http://corelib.rubyonrails.org/classes/Array.html), 
write code within that method that changes the `uncapitalized_string`
into a string with each word capitalized.  Then, use the function
 #capitalize_each_word just like we used the #number_to_currency
 to change each instance of the `from` field in the views to be
 capitalized.  Test it out.  Were you able to manipulate the 
 user-facing views using helper methods?
 
Adding Reporting on Data
------------------------

Now that our views look great, our client wants us to add a piece of
functionality.  They'd like to see the total dollar value of all
donations at the top of the index page.

Before we approach this problem, let's think about the life cycle of
a piece of data getting to the index page.  It sits in the database 
until the user hits the url and tries to load the page.  The 
Controller (apps/controllers/donations_controller.rb) loads up each
donation item into an instance of a Model (apps/models/donation.rb),
and then passes the collection of those instances into the View to
get displayed in the browser.  To calculate the total dollar value
of a collection of donations, we can define a class method on the 
donation Model that we can then call on a collection of donations.
It sounds confusing, but let's see it in practice.  In 
apps/models/donation.rb let's add a class method:

    class Donation < ActiveRecord::Base
      def self.total_amount
        all.inject {|sum, n| sum + n }
      end
    end
    
Within a class method on a Model, #all will return an array of all
of the donations in the collection this method was called on.  
[Inject](http://apidock.com/ruby/Enumerable/inject) is a Ruby method
that will execute a block of code on each element in an Array, 
accumulating a total value.  Now we can call `@donations.total_amount`
in the apps/views/donations/index.html.erb to display the total amount
of donations.  Don't forget to use the #number_to_currency method to
display it correctly!

Adding in Twitter
-----------------

Your client has been hearing a ton about social networking, and now
wants to include their twitter account on the index.  Luckily, there's
a gem that makes it very easy to access the Application Programming 
Interface (API) for Twitter from within a Ruby application.  To add
the Twitter gem to the application, open up the file called Gemfile
in the root of your application folder with your text editor and add
the line `gem 'twitter'`.  Then, in your terminal, run the `bundle`
command.  You have now successfully marked the twitter gem as a
dependency in your application and installed it.

You can look at the documentation for the twitter gem at its 
[documentation page](http://twitter.rubyforge.org/).  One feature 
you might want to try is to display your client's most recent tweet
on their index page.  From the API documentation, we could use the
following code:

    Twitter.user_timeline("bostonrb").first.text
    
If you don't have your own twitter to try with, feel free to use 
@bostonrb, like the line above.

Deploying to Heroku
-------------------

Your client is really happy, and you've really helped them out.  
However, they're sick of looking over your shoulder to view the
website.  This is where [Heroku](http://www.heroku.com/) comes in.

Heroku is a 'cloud application platform' that greatly simplifies
the workflow to deploying to a publicly-facing website.  There is a
start-up guide we'll be using, but before you start that, you'll
need to [create a Heroku login](https://api.heroku.com/signup).  Be
sure to read the terms and agreement involved in creating an account.
Once that is done, you should be ready to follow the 
[start-up guide.](https://devcenter.heroku.com/articles/rails3) This
guide assumes that you don't already have an app, so please
skip the steps entitled "Write Your App" and "Store Your App in Git,"
as both of those should already be accomplished.  