## Devops learnings
Concepts about devops


### LXC/LXD
This is the name Linux containers have. You need to have this software installed in order to run this repo in your Linux machine.

#### Install lxc
```
sudo apt-get install lxd
sudo lxd init
```
#### Install lxc Vagrant plugin
```
vagrant plugin install vagrant-lxc
```

Containers *LXC* are configured here in Linux/Ubuntu
```
/var/lib/lxc/
```

### Lxc command
```
sudo lxc-ls --fancy # List containers
sudo lxc-info -n NAME_OF_CONTAINER # View config
sudo vim /var/lib/lxc/NAME_OF_CONTAINER/config # When config is broken

```
### Resources

- [lxc manpages](https://linuxcontainers.org/lxc/manpages)
- [Setup network bridge with lxc-net](https://angristan.xyz/setup-network-bridge-lxc-net/#install-lxc-net)
