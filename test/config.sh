#!/bin/bash
set -e

testAlias+=(
	[piond:trusty]='piond'
)

imageTests+=(
	[piond]='
		rpcpassword
	'
)
