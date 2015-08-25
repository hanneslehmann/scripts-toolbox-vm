#!/usr/bin/env bash
echo "Starting install and configure ocaml..." > /var/log/bootstrap.log
	 ## install ocaml -- eventually as non privileged user
	 #cd /home/vagrant
	 #opam init -a
	 #opam update
	 #opam install iocaml -y