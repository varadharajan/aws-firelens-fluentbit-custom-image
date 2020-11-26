#!/bin/bash

set -e

[ -z $DATADOG_API_KEY ] && echo "Datadog disabled" || cat /custom-fluent-bit-datadog.conf.template >> /custom-fluent-bit.conf.template

envsubst < /custom-fluent-bit.conf.template > /custom-fluent-bit.conf

# Fallback to default entrypoint.
/bin/sh -c /entrypoint.sh
