#!/bin/bash

set -e

envsubst < /custom-fluent-bit.conf.template > /custom-fluent-bit.conf

# Fallback to default entrypoint.
/bin/sh -c /entrypoint.sh
