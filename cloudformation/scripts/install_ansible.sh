#! /bin/bash
VIRTUAL_ENV_PATH="$HOME/capstone_venv"

virtualenv --python=python3 "$VIRTUAL_ENV_PATH"
source "$VIRTUAL_ENV_PATH/bin/activate"
pip install -r files/requirements.txt
deactivate