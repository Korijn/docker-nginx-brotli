#!/bin/bash
set -euxo pipefail

rm -f results.log
touch results.log

expect_equal() {
    expected=$1
    actual=$2
    if [ "test_${expected}" == "test_${actual}" ]; then
        echo "OK" >> results.log
    else
        echo "FAIL (equality)" >> results.log
    fi
}

doCurl() {
    curl -sI -X GET localhost -H "accept-encoding: $1" | tr -d '\r' | grep -E "$2" | awk -F': ' '{ print $2 }'
}

expect_equal "br" $(doCurl 'br' 'Content-Encoding')
expect_equal "270" $(doCurl 'br' 'Content-Length')

exit $(cat results.log | grep -v 'OK' | wc -l)

