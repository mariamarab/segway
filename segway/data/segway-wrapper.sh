#!/usr/bin/env bash

## memory limit in kibibytes
MEMLIMIT="$1"

## the original temporary dir used by the submitting program (usually is /tmp)
SUBMIT_TMPDIR="$2"
shift 2

# -c 0: no core dump files
# -v: virtual memory
# -m: per process memory limit (no effect on newer Linuxes)
ulimit -c 0 -v "$MEMLIMIT" -m "$MEMLIMIT" || exit 201

if [ "${LSB_JOBID:-}" ]; then
    # this way, the post-exec script can delete it easily
    export TMPDIR="$(mktemp -dt "segway.$LSB_JOBID")"
else
    export TMPDIR="$(mktemp -dt segway.XXXXXXXXXX)"
fi

on_exit ()
{
    rm -rf "$TMPDIR"

    # delete any arguments that begin with $SUBMIT_TMPDIR
    for ARG in "$@"; do
        if [[ "$ARG" == "$SUBMIT_TMPDIR"* ]]; then
            rm -rf "$TMPDIR" 2>/dev/null || true
        fi
    done
}

trap on_exit EXIT

## start a subshell so that going over ulimit only kills the subshell
"$@"
