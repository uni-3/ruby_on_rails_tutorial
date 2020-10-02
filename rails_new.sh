#!/bin/sh
set -e
# db
#docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle
docker-compose run web rails new . --force --no-deps

# 作成されたファイルはrootのため
#sudo chown -R $USER:$USER .

# Gemfileが更新されるためbundle install
docker-compose build
