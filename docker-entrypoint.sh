#!/bin/bash

/usr/bin/supervisord -c /etc/mvp/supervisord.conf

"$@"