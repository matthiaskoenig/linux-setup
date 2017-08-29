#!/bin/bash

sudo rm -rf /usr/local/share/libsbml
sudo rm /usr/local/lib/pkgconfig/libsbml.pc
sudo rm -rf /usr/local/include/sbml/
sudo rm -rf /usr/local/lib/libsbml*
sudo rm /usr/local/lib/python2.7/site-packages/libsbml.pth
sudo rm -rf /usr/local/lib/python2.7/site-packages/libsbml
sudo rm /etc/profile.d/libsbml.sh

sudo rm -rf /usr/local/lib/python2.7/dist-packages/python_libsbml-5.15.0-py2.7-linux-x86_64.egg
