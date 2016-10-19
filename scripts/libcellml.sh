#!/bin/bash
############################################################
# Make cellml libraries available
#   http://cellml-api.sourceforge.net/download.html
#   https://www.cellml.org/tools/downloads/cellml_api/releases/1.11
#
# Usage: 
# 	./libcellml.sh 2>&1 | tee ./logs/libcellml.log
############################################################

#VERSION=cellml-sdk-1.11-Linux-x86_64
# VERSION=cellml-sdk-1.12-Linux-x86_64
VERSION=cellml-sdk-1.13-Linux-x86_64

TMP_DIR=$HOME/tmp
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi
cd ${TMP_DIR}

##############################
# Install prebuild library
##############################

# wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.12/20121031/linux-x86_64/${VERSION}.tar.bz2/download
# wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.11/20120418/linux-x86_64/${VERSION}.tar.bz2/download
wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.13/20130716/linux-x86_64/${VERSION}.tar.bz2/download
mv download ${VERSION}.tar.bz2
tar jxfv ${VERSION}.tar.bz2
rm ${VERSION}.tar.bz2

sudo cp ${TMP_DIR}/${VERSION} /usr/local/lib/

echo "Adding to LD_LIBRARY_PATH: /usr/local/lib/${VERSION}/lib"
cat > libcellml.sh << EOF0
#!/bin/bash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib/${VERSION}/lib
EOF0
sudo mv libcellml.sh /etc/profile.d/
source /etc/profile.d/libcellml.sh


##############################
# Build cellml
##############################

#sudo apt-get install omniidl
#
#cd ${TMP_DIR}
#API_VERSION=cellml-api-1.13
#wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.13/20130716/src/${API_VERSION}.tar.bz2/download
#mv download ${API_VERSION}.tar.bz2
#tar jxfv ${API_VERSION}.tar.bz2
#
#CELLML_BUILD=$TMP_DIR/cellml_build
#if ! [ -d "$CELLML_BUILD" ]; then
#	mkdir $CELLML_BUILD
#fi
#cd ${CELLML_BUILD}
#${TMP_DIR}/${VERSION}
#cmake -DCMAKE_INCLUDE_DIRECTORIES=${TMP_DIR}/${VERSION}/include -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CELLML_BUILD} ../${API_VERSION}/ 2>&1 | tee cellml.log
#
#make all
#make test
#make install
