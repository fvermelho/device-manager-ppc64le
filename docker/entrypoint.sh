#!/bin/bash
if [ $1 = 'start' ]; then
    flag=0
    retries=0
    max_retries=5
    sleep_time=5
    while [ $flag -eq 0 ]; do
        if [ $retries -eq $max_retries ]; then
            echo Executed $retries retries, aborting
            exit 1
        fi
        sleep $sleep_time
        exec gunicorn device-manager.app:app \
                  --bind 0.0.0.0:5000 \
                  --reload -R \
                  --access-logfile - \
                  --log-file - \
                  --env PYTHONUNBUFFERED=1 -k gevent 2>&1

        if [ $? -eq 0 ]; then
            flag=1
        else
            echo "Cannot start application, retying in $sleep_time seconds..."
            let retries++
        fi
    done
fi
