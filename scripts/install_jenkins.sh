if [ $(whoami) != "root" ]
then
    echo "You need to be root"
    exit 1
fi

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins