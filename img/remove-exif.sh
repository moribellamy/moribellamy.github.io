#!/bin/bash -x

exiftool -all= *.jpg *.jpeg *.png *.gif
rm *_original
