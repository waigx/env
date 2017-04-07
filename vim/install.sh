#!/usr/bin/env bash

scriptPath=$(dirname $0)
source "$scriptPath/lib.sh"


info "Installing packages ..."
"$scriptPath/packages.sh"
