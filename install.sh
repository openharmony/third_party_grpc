#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
if [ -d "grpc-1.41.1" ];then
    rm -rf grpc-1.41.1
fi
tar xvf grpc-1.41.1.tar.gz
cd $1/grpc-1.41.1
patch -p1 < $1/src_core_lib_debug.patch --fuzz=0 --no-backup-if-mismatch
patch -p1 < $1/src_core_lib_iomgr.patch --fuzz=0 --no-backup-if-mismatch
exit 0