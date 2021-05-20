#!/bin/bash -x

#gappa -Munconstrained cg.g
gappa  -Wno-null-denominator -Wno-dichotomy-failure cg.g
