## Creating AMI
```bash
cd packer/web/
packer build template.json
```

## Cloning repository
```bash
cd build/app/
git clone https://github.com/joonaskaskisola/taskmanager application/
```

## Creating necessary resources @ AWS
1. LaunchConfiguration
2. IAM role
- Permissions
    - AmazonEC2FullAccess
    - AmazonS3FullAccess
- Trust relationships
 ```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
3. Security Group
    - Name: MyAppSecurityGroup
    - HTTP/80 - 0.0.0.0/0
    - TCP/11211 (source: self)
4. Launch Configuration
    - Name: MyAppLaunchConfiguration
    - AMI ID
        - Previously created AMI
    - IAM
        - Previously created IAM role
    - Security Groups
        - Previously created SG
5. Auto Scaling Group
    - LaunchConfiguration: MyAppLaunchConfiguration
6. ElastiCache
    - Type: Memcached
7. RDS
8. CodeDeploy
9. S3

## Configuring
    - Modify deploy/deploy.sh if necessary
    - Copy insert-configs-example.sh to insert-configs.sh and edit it if necessary

## Deploying
```bash
cd deploy/app/
./prepare-for-build.sh
cd ..
./deploy.sh
```
