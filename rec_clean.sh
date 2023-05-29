#!/bin/bash
# Copyright (c) 2022 Mantano. All rights reserved.
# Unauthorized copying of this file, via any medium is strictly prohibited.
# Proprietary and confidential.

folders=(
  "reader_widget"
)
for i in "${folders[@]}"; do
  echo "flutter clean $i"
  (cd "$i" || exit; flutter clean)
done
