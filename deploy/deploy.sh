#!/bin/bash

APPNAME="taskio-7-WebServerApplication-C9MFK5BHQFVQ";
DEPLOYMENT_GROUP="taskio-7-DeploymentGroup-10IB7UAZYQ3R4";
DATE=$(date '+%Y-%m-%d');
TIME=$(date '+%s');
PACKAGE=$(echo "${APPNAME}-${DATE}-${TIME}.tar.gz");
S3_BUCKET="taskio-7-s3bucket-1ak1xxmyt2a3r"

cd app/
#./prepare-for-build.sh

tar -czvf ../builds/$PACKAGE --exclude './application/node_modules/*' --exclude './application/.git/*' --exclude './application/.idea/*' --exclude './application/app/cache/*' .
aws s3 cp ../builds/$PACKAGE s3://$S3_BUCKET/builds/

aws deploy create-deployment \
	--application-name=$APPNAME \
	--deployment-group-name=$DEPLOYMENT_GROUP \
	--ignore-application-stop-failures \
	--s3-location bundleType=tgz,bucket=$S3_BUCKET,key=builds/$PACKAGE \
	--description "$PACKAGE"
