#!/usr/bin/env bash

emacs -L . -l echoes-test --batch -f ert-run-tests-batch-and-exit

