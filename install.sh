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
tar -zxvf grpc-1.60.0.tar.gz
mv grpc-1.60.0 grpc
cd $1/grpc
patch -p1 < $1/backport-CVE-2024-7246-chttp2-Fix-a-bug-in-hpack-error-handling.patch
patch -p1 < $1/backport-CVE-2024-11407.patch
patch -p1 < $1/backport-Specify-noexcept-for-cdef-functions.patch
flock -u 100
} 100<>$1/lock_file.lock
exit 0