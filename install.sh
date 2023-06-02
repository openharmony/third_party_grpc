#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
if [ ! -d "grpc" ];then
    mkdir grpc
    tar -zxvf grpc-1.41.1.tar.gz --strip-components 1 -C ./grpc
    cd $1/grpc
    patch -p1 < $1/src_core_lib_debug.patch
    patch -p1 < $1/src_core_lib_iomgr.patch
fi
exit 0