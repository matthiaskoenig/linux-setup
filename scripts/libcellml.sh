#!/bin/bash
############################################################
# Make cellml libraries available
#   http://cellml-api.sourceforge.net/download.html
#
# Usage: 
# 	./libcellml.sh 2>&1 | tee ./logs/libcellml.log
############################################################

VERSION=cellml-sdk-1.12-Linux-x86_64

TMP_DIR=$HOME/tmp
if ! [ -d "$TMP_DIR" ]; then
	mkdir $TMP_DIR
fi

cd ${TMP_DIR}

wget https://sourceforge.net/projects/cellml-api/files/CellML-API-Nightly/1.12/20121031/linux-x86_64/${VERSION}.tar.bz2/download
mv download ${VERSION}.tar.bz2
tar jxfv ${VERSION}.tar.bz2
rm ${VERSION}.tar.bz2

sudo mv ${TMP_DIR}/${VERSION} /usr/local/lib/

echo "Adding to LD_LIBRARY_PATH: /usr/local/lib/${VERSION}/lib"
cat > libcellml.sh << EOF0
#!/bin/bash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib/${VERSION}/lib
EOF0
sudo mv libcellml.sh /etc/profile.d/
source /etc/profile.d/libcellml.sh

