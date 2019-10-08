## Running a containerized version of a cli application for personal use

This is a simple example of how to run an application in a containerized way in a Linux machine. 
There are many reason to why someone should run an application like this. For safety reason, or environment reasons, for example.

Here, we use the [athenacli](https://github.com/dbcli/athenacli) since, at the time of writing, the tool is using an older version of dependencies that currently conflict with my workflow.
Also, I will be using it in a read only fashion, which means it won't have to write data to the host machines disk, but the example can be easily configurable.

### Setting up the Dockerfile and build directory

In the dockerfile, I install some environment variables that can be explicitly written (i.e. no secrets or anything). Also install a better `PAGER` that wont break with tmux (my referred tool).
This is just an example to customize the environment in how you prefer to use a tool. In the same fashion, I have, on the host's directory where I will build the image, artifacts that will be used by the tool (the .athenacli directory)

The build directory, in this example, is this repository it self.


### Building the image

Now, a trick that simplifies things is creating a tag for the image that will be built. This is done by the `-t athenacli_container` flag in the following command:

```bash
docker build . -t athenacli_container
```

### Running the image and setting an alias

Now, in order to run the application, we have to run the container. In this specific case, we also have to send some sensitive information in order to run the athenacli tool. We can rely on some bash-fu and on the awscli python package. Check out the following command:

```bash
docker run -ti -e AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id) \
               -e AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key) \
               -v $(pwd):/home/athena \
               athenacli_container athenacli
```

There is a lot going on here:

- the -it flag tells the `docker run` that we want to run interactively and with a tty (prompt) so that we can interact with the tool through the command line.
- the -e flag sets some environment variables at run time for the image. We programmatically get them from the awscli
- the -v maps the current directory to the image's home directory, in case I want to access something from it
- we tell the run command that we want to run the image tagged athenacli_container, that we tagged in the build command
- the last command is the command we want to run withing the container. This could have been `python script.py` or anything else. Running `bash` here is a good idea if you need to debug the image by looking around the operating system. 


Now, the suggestion here is simple. Place, on your .alias, or .bashrc, or .zshrc, that very same command:

```bash
alias athena_cli_alias='docker run -ti -e AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id) \
                  -e AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key) \
                  -v $(pwd):/home/athena \
                  athenacli_container athenacli'
```

Now the running of the alias will run the container.


### Next steps

- making sure we can write and read to disk in case the application needs.
- mapping web application to ports and using them in our browsers.
- having multiple containers interacting.














