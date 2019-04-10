#!/bin/bash

mkdir EMPTY_DIR
rsync -a --delete EMPTY_DIR/ BIGDIR/
rmdir EMPTY_DIR
