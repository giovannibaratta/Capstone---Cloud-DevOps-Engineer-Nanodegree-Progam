#! /bin/bash
# $1 -> path where to create the virtual env (ex ~/my_virtual_env)

if [ $(whoami) != "root" ]
then
    echo "You must be root."
    exit 1
fi

if [ "$#" -ne 1 ]
then
    echo "Missing virtualenv directory arguments"
    exit 2
fi

VIRTUAL_ENV_PATH="$1"

if [ -d $VIRTUAL_ENV_PATH ]
then
    echo "$VIRTUAL_ENV_PATH alredy exists."
    exit 3
fi

apt update -y && apt install -y virtualenv

if [ "$?" -ne 0 ]
then
    echo "Installation failed."
    exit 4
fi

echo "Installation completed."

virtualenv --python=python3 "$VIRTUAL_ENV_PATH"
source "$VIRTUAL_ENV_PATH/bin/activate"
pip install -r local_python_requirements.txt
deactivate