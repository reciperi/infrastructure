
# DEVENV
To ease the pain of installing a working development environment in lolB,
we support a dev environment called **devenv**, that creates a virtual machine from scratch,
and sets up your local environment to deal with it.

## Quick Start
In short, you need to:

```
bundle install
bundle exec bin/comander setup
bundle exec bin/comander devenv up
bundle exec bin/comander devenv start_servers
```

Point your favorite browser to **http://dev.reciperi.com** and enjoy

## Installation

The installation is simple, you just have to execute

```
bundle install
bin/comander setup
```

This installs everything you need to start the virtual machine. After that

```
bin/comander devenv up
```

Will create the virtual machine.

Once you have done it, you can start using it.

### What gets installed in my box?

The virtual machine is set up using virtual box and vagrant. If you are in Mac you need hombrew for this to work.

Also a couple of gems are going to be installed (puppet, thor, etc) and **some hosts are added to you internal /etc/hosts file**.

## How does the devenv work?
The behavior is simple. The virtual machine shares most of the configuration that is used in the rest of the infrastructure. When
we create a new server, we fetch the application code from github and peform a deploy inside it (actually using capistrano). In this case
instead of fetching the code from github whe use a local copy that is inside the VM. Those directories are exported using NFS, so you can use
your favorite editor to use it.

Also, servers for "developable" applications are not automatically started so you can start
them foreground. **Comander** simplify that for you also.

You have to understand that everything is run inside the virtual machine. If you want
to add a new gem, for example, the bundle install has to be run from inside the VM, never outside (in the mounted directory)..

In the devenv virtual machine every application runs with the same user so you should not bother about credentials, etc.

## How do I start servers inside the VM so I can start developing?
There is a tmuxinator config file for that

```
bin/comander devenv start_servers
```

That starts up needed servers in foreground. Technically doing that, you have a working environment.

## How do I apply infrastructure changes into the devenv environment
The VM is prepared for provisioning using the state of the infrastructure repo.

```
$> ./bin/comander devenv provision
```

Will apply puppet using the current branch/code.

## What else can I do with the devenv
Well, use the help from comander, new things are going to be added there, the idea is to have self explanatory/documented commands.

```
$> ./bin/comander help devenv
Commands:
  comander devenv destroy               # destroys the devenv environment
  comander devenv exec_command COMMAND  # Runs a command inside the devenv environment
  comander devenv halt                  # Halts the devenv environment
  comander devenv help [COMMAND]        # Describe subcommands or one specific subcommand
  comander devenv provision             # Provisions the devenv environment
  comander devenv reload                # Reloads the devenv environment
  comander devenv ssh                   # Sshs into the devenv environment
  comander devenv start_servers         # Starts servers inside devenv in foreground
  comander devenv up                    # Starts the devenv environment (this is a alias of vagrant devenv up)
```

## How do I mount the internal NFS
In order to work with applications you need to mount the code in your box. In MaxOSX that is:

```
sudo mount -t nfs  -o noowners,soft,vers=3,resvport dev.reciperi.com:/srv/app/releases/devenv/       APP_DEST_DIR
sudo mount -t nfs  -o noowners,soft,vers=3,resvport dev.reciperi.com:                                HOME_DIR
```

In Linux
```
sudo mount -o nfsvers=3 dev.reciperi.com:/srv/frontend/releases/devenv     FRONTEND_DEST_DIR
sudo mount -o nfsvers=3 dev.reciperi.com:/srv/app/releases/devenv          API_DEST_DIR
sudo mount -o nfsvers=3 dev.reciperi.com:/srv/wordpress/releases/devenv    WORDPRESS_DEST_DIR
sudo mount -o nfsvers=3 dev.reciperi.com:                                  HOME_DIR

```
