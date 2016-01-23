#!/bin/bash
echo "--------------------------------------"
echo "python bindings"
echo "--------------------------------------"

# add a file with the path settings to /etc/profile.d
echo "Adding to PYTHONPATH: /usr/local/lib/python2.7/site-packages/libsbml"
cat > libsbml.sh << EOF0
#!/bin/bash
export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsbml
EOF0
sudo mv libsbml.sh /etc/profile.d/
source /etc/profile.d/libsbml.sh

# add a file with the path settings to /etc/profile.d
echo "Adding to PYTHONPATH: /usr/local/lib/python2.7/site-packages/libnuml"
cat > libnuml.sh << EOF1
#!/bin/bash
export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python2.7/site-packages/libnuml
EOF1
sudo mv libnuml.sh /etc/profile.d/
source /etc/profile.d/libnuml.sh

# add a file with the path settings to /etc/profile.d
echo "Adding to PYTHONPATH: /usr/local/lib/python2.7/site-packages/libsedml"
cat > libsedml.sh << EOF2
#!/bin/bash
export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python2.7/site-packages/libsedml
EOF2
sudo mv libsedml.sh /etc/profile.d/
source /etc/profile.d/libsedml.sh


