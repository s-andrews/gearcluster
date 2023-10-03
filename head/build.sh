# Get basic packages updated
dnf -y update

# Add the new packages we need
dnf -y install chrony krb5-libs krb5-workstation sssd-krb5 sssd-tools sssd-dbus authselect-compat

# Configure NTP
systemctl enable --now chronyd

# Write the chrony.conf file

# Configure the timezone
timedatectl set-timezone Europe/London

# Configure authentication
cat "
[sssd]
config_file_version = 2
services = pam, nss, ifp, ssh
domains = BABRAHAM.AC.UK

[domain/BABRAHAM.AC.UK]
id_provider = files
debug_level = 5
auth_provider = krb5
chpass_provider = krb5
krb5_realm = BABRAHAM.AC.UK
krb5_server = BABRAHAM.AC.UK:88
krb5_validate = false
krb5_rcache_dir = /var/tmp
" > /etc/sssd/sssd.conf

chmod 600 /etc/sssd/sssd.conf
systemctl restart sssd
systemctl restart dbus
authconfig --enablesssd --update
authconfig --enablesssdauth --update 

# Enable sudo

# Setup fstab

# Setup FUSE filesystems

# Disable selinux

# Set up lynis

# Set up slurm

# Set up PXE server

# Set up DNS





