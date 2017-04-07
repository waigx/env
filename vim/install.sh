#!/usr/bin/env bash

scriptPath=$(dirname $0)
source "$scriptPath/util/lib.sh"


info "Installing packages ..."
"$scriptPath/util/packages.sh"
