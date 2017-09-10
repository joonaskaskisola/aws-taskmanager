## Step 1: Creating AMI
```bash
cd packer/web/
packer build template.json
```

After you have successfully obtained the newly created ami-id from packer, insert it to `cloudformation.json`, and upload the template to CloudFormation. This creates automatically all the necessary resources for the application to work properly.

## Step 2: Cloning repository
```bash
cd build/app/
git clone https://github.com/joonaskaskisola/taskmanager application/
./prepare-for-build.sh
```

## Step 3: Deploying the application to AWS
Before running `deploy.sh`, you must edit the following variables in `deploy.sh`:
- `APPNAME`
- `DEPLOYMENT_GROUP`
- `S3_BUCKET`

You can get the needed variable values from Cloudformations "Outputs"-tab.
 
```bash
./deploy.sh
```

After successful deployment, the application should be visible in `ELBUrl`