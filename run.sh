#!/usr/bin/env bash

java --version
FULL="$(java --version | head -1 | cut -d ' ' -f 2)"
MAJOR="$(echo "$FULL" | cut -d '.' -f 1)"

[ -d build-$MAJOR ] && \rm -rf build-$MAJOR*
for v in 0 $(($MAJOR)) $(($MAJOR - 1)) $(($MAJOR - 2))
do
  OUT=build-$MAJOR-$v
  RELEASE=" --release $v"
  [ $v -eq 0 ] && RELEASE=""
  echo "'javac$RELEASE'"
  javac -d $OUT $RELEASE --module-source-path src src/*/*.java
  javap -v $OUT/*/module-info.class | grep -A 2 '// require'
done