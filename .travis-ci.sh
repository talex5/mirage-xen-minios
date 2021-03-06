#!/bin/sh
set -eux
sudo apt-get install -qq build-essential pkg-config

case "$OCAML_VERSION,$OPAM_VERSION" in
4.01.0,1.2.0) ppa=avsm/ocaml41+opam12 ;;
*) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam

export OPAMYES=1
export OPAMVERBOSE=1
opam init

opam pin -k git add mirage-xen-minios .
opam install mirage-xen-minios
opam install mirage-xen
