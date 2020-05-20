#! /bin/bash
if [ $(whoami) != "root" ]
then
    echo "You must be root."
    exit 1
fi

apt update -y && apt install -y virtualenv

if [ "$?" -ne 0 ]
then
    echo "Installation failed."
    exit 1
fi

echo "Installation completed."
exit 0