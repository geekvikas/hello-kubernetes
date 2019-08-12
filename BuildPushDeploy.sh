
REPO="findvikas"
IMAGE="helloweb"
VERSION="v0.6"
BUILD=`date -u`
REPLICAS=1

###############################################
#####          DO NOT EDIT BELOW          #####   
###############################################

rm deployment.yaml                          # Remove old Deployment file
cp deployment.template deployment.yaml      # Copy template into target file

sed -i -e 's/{REPO}/'"$REPO"'/g' deployment.yaml            # Add the Repo Name in Template
sed -i -e 's/{IMAGE}/'"$IMAGE"'/g' deployment.yaml          # Add the Image Name in Template
sed -i -e 's/{VERSION}/'"$VERSION"'/g' deployment.yaml      # Add the Version Number in Template
sed -i -e 's/{BUILD}/'"$BUILD"'/g' deployment.yaml          # Add the Build Date/Time in Template
sed -i -e 's/{REPLICAS}/'"$REPLICAS"'/g' deployment.yaml    # Add the Replicas in Template


docker build -t $REPO/$IMAGE:$VERSION .         # Create a new Docker Image
docker push $REPO/$IMAGE:$VERSION               # Push the Docker Image into Registry / Docker Hub
kubectl apply -f deployment.yaml                # Configure the k8s to Run the modified template
