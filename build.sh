#!/bin/bash
set -e

TAG_BASE=nemooudeis/android-sdk

TAG_VERSION=(
  jdk8
  jdk11
)
JDK_IMAGE=(
  adoptopenjdk:8u232-b09-jdk-hotspot
  adoptopenjdk:11.0.5_10-jdk-hotspot
)

echo "================================================"
echo "Building android SDK image"
echo "================================================"
docker build \
    --pull \
    --tag android-sdk \
    android-sdk

for ((i=0;i<${#JDK_IMAGE[@]};++i)); do
    TAG=${TAG_BASE}:${TAG_VERSION[i]}

    echo "================================================"
    echo "Building ${TAG} image"
    echo "================================================"

    docker build \
        --tag ${TAG} \
        --build-arg JDK_IMAGE=${JDK_IMAGE[i]} \
        jdk

    docker push ${TAG}
done
