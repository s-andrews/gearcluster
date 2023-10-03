# Cluster Design

## Concept
We will have a main head node ```headgear``` which is dual interfaced to both the intranet and the internal private network.

The head node will run a bunch of services:

1. DNS for all internal nodes
2. Internet routing
3. NTP
4. Slurm queueing
5. Config management (file sync)
6. Authentication and account management

Nodes will then be built from the head node.  We're going to aim to keep a pretty minimal image on the nodes and we will rebuild them more often. The idea would be to use a config script to do the basic image build and configure the core package set and the networking setup.  This would be a common script for all nodes with the exception of them picking up some basic configuration (mostly just hostname and ip address) from the head node.  We can probably do this through kickstart, or we could do it with a more manual build depending on what ends up being easier.

This is the [reference for kickstart booting](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-howto) - doing a PXE would be best

This is the [syntax reference for kickstart](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-syntax) to see if we can get everything working

## Node setup
Things that need setting up on the nodes

1. Package set - just a bunch of dnf installs
2. SSH key setup - so that the head node can do stuff on the compute nodes
3. FSTAB so that we can mount the appropriate shares
4. Slurm client setup. We also need to register new nodes on the head
5. User setup - copying ```passwd group shadow``` from the head

I'm sure there will be more things.

## Files to sync

* /etc/passwd
* /etc/group
* /etc/shadow
* /etc/fstab
* /etc/chrony.conf
* /etc/sssd/sssd.conf [maybe? not sure if we need password auth on compute nodes]
* /etc/sudoers
* 
