# Download and Install Zimbra

Zimbra is a collaborative software suite that includes an email server and a web client. It's FOSS and avalible under this [licence](https://www.zimbra.com/product/licenses-and-terms-of-use/)

Zimbra requires the following to install properly:
1. Ubuntu/CentOS operatin system
1. Static IP
1. Domain name
1. MX record 

Since I have these [limitations](../Limitations.md), I decided to install Zimbra on Ubuntu-20.04-LTS (see [licence](https://ubuntu.com/legal/open-source-licences?release=focal)). I then gave it a static IP and hosted a local DNS server (using dnsmasq see [licence](https://github.com/sous-chefs/dnsmasq/blob/main/LICENSE)) 

## Creating Virtual Machine
1. VirtualBox was downloaded and installed using pacman on my Arch-Linux host.

```
pacman -S virtualbox virtualbox-guest-iso 
sudo gpasswd -a $USER vboxusers
sudo modprobe vboxdrv
```

1. Ubuntu live-server 20.04 LTS iso was downloaded from [here](https://mirror.ubuntu.bsr.one/20.04.6/ubuntu-20.04.6-live-server-amd64.iso).

1. Virtual Machine was created with following configurations. 

![alt](../images/vm-conf.avif)
![alt](../images/vm-conf2.avif)

Here the Network adapter 1 is set in Bridged Mode (can also be NAT mode) for internet connection to the VM. Adapter 2 is in Host-Only mode (vboxnet0)

![alt](../images/vboxnet-settings.avif)

Since there was only one VM on my machine it automatically got the IP 192.168.56.3 (by DHCP). It's not really 'static' since it was assigned via DHCP but everytime my VM got this IP on boot.

If there are multiple VM's on your system a static IP can be assigned using:
```
VBoxManage dhcpserver add --netname "vboxnet0" --ip 192.168.56.1 --netmask 255.255.255.0 --lower-ip 192.168.56.3 --upper-ip 192.168.56.254 --enable

VBoxManage dhcpserver modify --netname "vboxnet0" --vm "Zimbra" --mac-address 080027D93854 --fixed-address 192.168.56.10
```

This will assign static ip 192.168.56.10 to VM named Zimbra, with network card MAC 080027D93854

On the VM i need to do the following to fetch the IP
```
sudo dhclient enp0s8
```

## Configuring local DNS
DNS was hosted using dnsmasq (and removing systemd-resolved service)

```
sudo apt install dnsmasq
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
```

Setting the correct hostname
```
hostnamectl set-hostname mail.fossee-application.in
``` 

Following configurations were done:

In **/etc/dnsmasq.conf**
```
address=/mail.fossee-application.com/127.0.0.1
address=/zimbra.localdomain/127.0.0.1
mx-host=mail.fossee-application,mail.fossee-application.com,50
mx-target=mail.fossee-application.com
```

In **/etc/hosts**
```
127.0.0.1 localhost.localdomain localhost
::1 localhost6.localdomain6 localhost6
127.0.0.1 mail.fossee-application.com zimbra
192.168.56.3 mail.fossee-application.com
```

and finally
```
sudo systemctl restart dnsmasq
```

The DNS records can be verified with **dig**
```
dig -t A mail.fossee-application.in
dig -t MX mail.fossee-application.in
```

## Zimbra installation
System update
```
apt update && apt upgrade -y
``` 

Zimbra installer download, extraction and start
```
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz

tar xvzf zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz

cd zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954

sudo ./install.sh
```

All the packages were selected for install except:
1. **zimbra-dnscache** (caused some conflicts with local DNS)
1. **zimbra-drive** (used for syncing mails, not needed for test install)
1. **zimbra-chat** (unneccessary package)

Admin Password was also set.

On the ArchLinux host 192.168.56.3 was configured as mail.fossee-application.com

In **/etc/hosts**
```
192.168.56.3 mail.fossee-application.com
```

The server was accessable on mail.fossee-application.com:7071 on ArchLinux Host

## Conclusion
A functional Zimbra server was installed on a Ubuntu Live-Server 20.04 LTS Virtual Machine, which was given a static IP and appropriate MX record. Hence the step is successfully done.