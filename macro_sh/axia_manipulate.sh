#!/bin/bash
type="R00${2}_RURL"

curl -u user:opsteam --data "cmd=set&R00${2}_RURL=$3&R00${2}_TYPE=4022337536" http://$1/cgi-bin/cgi_dsts
