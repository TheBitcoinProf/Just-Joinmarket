VERSION=$(cat VERSION)

TAR_FILENAME="joinmarket.tar.gz"
JM_DIR_NAME="joinmarket"

USERNAME="thebitcoinprof"
IMAGE_NAME="just-joinmarket"
FULL_IMAGE_NAME="${USERNAME}/${IMAGE_NAME}"

curl -L -o ${TAR_FILENAME} "https://github.com/JoinMarket-Org/joinmarket-clientserver/archive/refs/tags/v${VERSION}.tar.gz"

mkdir ${JM_DIR_NAME}

tar -xvzf ${TAR_FILENAME} -C ${JM_DIR_NAME} --strip-components 1

rm -f ${TAR_FILENAME}

docker build -t ${FULL_IMAGE_NAME} ./${JM_DIR_NAME}/

rm -rf ${JM_DIR_NAME}

git tag -a "$VERSION" -m "Version $VERSION"
git push origin "$VERSION"

docker tag ${FULL_IMAGE_NAME}:latest ${FULL_IMAGE_NAME}:"${VERSION}"

docker push ${FULL_IMAGE_NAME}:latest
docker push ${FULL_IMAGE_NAME}:"${VERSION}"