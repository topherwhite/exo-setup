#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

ACTION=$1

REPO_DIR="$SCRIPT_DIR/exo"

if [ "$ACTION" = "sync_models" ]; then

	MODELS_DIR_LOCAL="$HOME/.cache/exo/downloads"

	mkdir -p $MODELS_DIR_LOCAL

	MODELS_DIR_CACHE="/Volumes/NAS/Cluster/_cache/exo/downloads_active"
	MODELS_DIR_ADDRESS="//plexbackup:derc0956@qnap10g/PlexBackup"

	if [ ! -d "$MODELS_DIR_CACHE" ]; then
		echo "Cannot find Model backup directory (NAS)"
	else 
		echo "syncing exo models from NAS..."
	fi

elif [ "$ACTION" = "install" ]; then

	if [ ! -d "$REPO_DIR" ]; then
		git clone https://github.com/exo-explore/exo $REPO_DIR

		$SCRIPT_DIR/scr/text_search_replace.sh $REPO_DIR/setup.py "grpcio==1.71.0" "grpcio==1.70.0"
		$SCRIPT_DIR/scr/text_search_replace.sh $REPO_DIR/setup.py "grpcio-tools==1.71.0" "grpcio-tools==1.70.0"

		/opt/homebrew/bin/pyenv install 3.12.9 --skip-existing
		/opt/homebrew/bin/pyenv uninstall --force exo
		/opt/homebrew/bin/pyenv virtualenv 3.12.9 exo
		sudo $REPO_DIR/configure_mlx.sh
	fi

elif [ "$ACTION" = "reinstall" ]; then
	
	if [ -d "$REPO_DIR" ]; then
		rm -rf $REPO_DIR
	fi 

	$SCRIPT_DIR/exo.sh install

elif [ "$ACTION" = "run" ]; then

	$SCRIPT_DIR/exo.sh install
	$SCRIPT_DIR/exo.sh sync_models

	cd $REPO_DIR
	git pull
	/opt/homebrew/bin/pyenv local exo
	~/.pyenv/versions/3.12.9/bin/python3.12 -m venv .venv
	source .venv/bin/activate
	pip3.12 install --upgrade pip
	pip install -e .
	pip install tensorflow flax

	sudo $REPO_DIR/configure_mlx.sh
	
	exo

	deactivate

else 
	echo "invalid action specified..."
fi


