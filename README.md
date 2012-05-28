bostonrb-examples
=================

This repo contains a stub of a Ruby On Rails application as well 
as some exercises for a beginner to attempt. By following the 
instructions on this page, you will see examples of:
-cloning into an existing code repository with git
-using rails helper functions to format the display of information
 on your web page
-writing methods on a Model to add function to your application
-use an external library, or gem, to interface with an outside
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