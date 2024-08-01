#!/bin/bash
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation version 2.1
# of the License.
#
# Copyright(c) 2023 Huawei Device Co., Ltd.

set -e
cd $1
{
flock -x 100
if [ -d "grpc" ];then
    rm -rf grpc
fi
tar -zxvf grpc-1.41.1.tar.gz
mv grpc-1.41.1 grpc
cd $1/grpc
patch -p1 < $1/src_core_lib_debug.patch
patch -p1 < $1/src_core_lib_iomgr.patch
patch -p1 < $1/backport-Ignore-Connection-Aborted-errors-on-accept-29318.patch
patch -p1 < $1/backport-iomgr-EventEngine-Improve-server-handling-o.patch
patch -p1 < $1/fix-CVE-2023-33953-add-header-limit.patch
patch -p1 < $1/fix-CVE-2023-44487.patch
flock -u 100
} 100<>$1/lock_file.lock
exit 0