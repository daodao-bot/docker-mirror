#!/bin/sh
echo "todo..."

echo "docker login..."
docker login -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD $DOCKER_REGISTRY_URL

filename="images.txt"
echo "reading images..."

while read -r line
do
    source_image="$line"
    target_image=$(echo $source_image | sed 's/\//./g')

    echo "pull image - $source_image"
    docker pull $source_image

    echo "tag image - $source_image > $target_image"
    docker tag $source_image $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_NAMESPACE/$target_image

    echo "push image - $target_image"
    docker push $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_NAMESPACE/$target_image

done < "$filename"

echo "done!"
