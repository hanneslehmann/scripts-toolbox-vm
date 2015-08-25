#!/usr/bin/env bash
	 echo "Starting Bootstrap..." >> /var/log/bootstrap.log
	 #BASE_DIR='/opt/workon' && mkdir $BASE_DIR && chmod a+w $BASE_DIR && export WORKON_HOME=$BASE_DIR/Envs  && chmod a+w $BASE_DIR/Envs && echo "export WORKON_HOME=$BASE_DIR/Envs" >> /etc/bash.bashrc
	 #source /usr/local/bin/virtualenvwrapper.sh && echo "source /usr/local/bin/virtualenvwrapper.sh" >> /etc/bash.bashrc
	 #BASE_DIR='/opt/workon' && export WORKON_HOME=$BASE_DIR/Envs && echo "export PIP_VIRTUALENV_BASE=$WORKON_HOME" >> /etc/bash.bashrc "
	 # cd /tmp && wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.2/PyQt-x11-gpl-4.11.2.tar.gz
	 cd /tmp && wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz 
	 cd /tmp && wget http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.4/sip-4.16.4.tar.gz
	 cd /tmp && tar -zxvf PyQt-x11-gpl-4.11.4.tar.gz
	 cd /tmp && tar -zxvf sip-4.16.4.tar.gz
	 cd /tmp/sip-4.16.4/ && python configure.py && make && make install
	 cd /tmp/sip-4.16.4/ && python3 configure.py && make && make install
     ##Remove need for user input in the middle of the script - TODO: move this to start of script.
	 sed -i 's/resp = sys.stdin.readline()/resp = "yes"/g' /tmp/PyQt-x11-gpl-4.11.4/configure-ng.py
	 cd /tmp/PyQt-x11-gpl-4.11.4/ && python configure-ng.py && make && make install
	 cd /tmp/PyQt-x11-gpl-4.11.4/ && python3 configure-ng.py && make && make install
	 
	 cd /tmp && rm *.tar.gz
	 
	 ### Install iPython and prerequisites
	 pip install markupsafe certifi pyzmq jinja2 tornado jsonschema functools32 numpy  pysimplesoap ipython-sql nxpd redis pymongo mpld3 mysql-python python-etcd elasticsearch statsmodels petl cassandra-driver blist --upgrade
	 pip install git+https://github.com/vispy/vispy.git
	 pip3 install redis pymongo mpld3 pyzmq  nxpd numpy  pysimplesoap ipython-sql python-etcd mysqlclient cassandra-driver blist
	 pip3 install git+https://github.com/vispy/vispy.git
	 pip install "ipython[all]"
	 pip3 install "ipython[all]"
	 
	 cd ~
	 wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
     python ez_setup.py
     python3 ez_setup.py
	 easy_install -U distribute
	  
	 ### Install NodeJS-Kernel
	 mkdir -p /home/vagrant/kernel_node 
	 cd /home/vagrant/kernel_node && wget https://github.com/notablemind/jupyter-nodejs/releases/download/v1.1.0/jupyter-nodejs-1.1.0.tgz
	 cd /home/vagrant/kernel_node && tar xf jupyter-nodejs-1.1.0.tgz
	 mkdir -p /home/vagrant/.ipython/kernels/nodejs
	 chown -R vagrant:vagrant /home/vagrant/
 
	 ### Install IHaskell
	 #cd /home/vagrant/ && git clone http://www.github.com/gibiansky/IHaskell --depth=1
	 #cabal update
	 #cabal install cabal cabal-install 
	 #cd /home/vagrant/IHaskell/ && ./ubuntu_install.sh all # Build and install IHaskell
	 
	 ## Install Go-Kernel
	 #sudo -H -u vagrant bash -c "echo 'export GOPATH=\\\$HOME/go' >> ~/.profile"
	 #sudo -H -u vagrant bash -c "echo 'export GOROOT=/usr/share/go' >> ~/.profile"
     #su vagrant -c "echo 'export PATH=\$PATH:\\\$GOPATH/bin' >> ~/.profile"
	 #sudo -H -u vagrant bash -c 'mkdir /home/vagrant/go'
	 sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/.ipython/kernels/igo"
	 sudo -H -u vagrant bash -c 'cd /home/vagrant/ && source .profile && go get -tags zmq_3_x github.com/takluyver/igo'
	 sudo -H -u vagrant bash -c 'cd /home/vagrant/ && source .profile && cp -r /home/vagrant/go/src/github.com/takluyver/igo/kernel/* /home/vagrant/.ipython/kernels/igo'
	 sed -i 's/\$GOPATH/\/home\/vagrant\/go/g' /home/vagrant/.ipython/kernels/igo/kernel.json
	 
	 ## Install LUA Kernel
	 #sudo -H -u vagrant bash -c "git clone https://github.com/facebook/iTorch.git --depth=1"
     #sudo -H -u vagrant bash -c "cd /home/vagrant/iTorch && luarocks make --local"
	 #sudo -H -u vagrant bash -c "cd /home/vagrant/iTorch && luarocks install image --local"
	 #sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/.ipython/kernels/itorch"
	 #sudo -H -u vagrant bash -c "cp /home/vagrant/iTorch/kernelspec/*.* /home/vagrant/.ipython/kernels/itorch"
	 #sed -i 's/LUA_BINDIR/\/home\/vagrant\/iTorch/g' /home/vagrant/.ipython/kernels/itorch/kernel.json
	 #chown -R vagrant:vagrant /home/vagrant/
  
	 # Execute Kernel Setup
	 pip install bash_kernel 
	 chown vagrant:vagrant -R /home/vagrant/
	 sudo -H -u vagrant bash -c "cd /home/vagrant && cat /home/vagrant/r_install.script | R --no-save >> /home/vagrant/r_install.log 2>&1"
	 cd /home/vagrant/kernel_node/package && sudo -u vagrant -H npm install
	 cd /home/vagrant/kernel_node/package && sudo -u vagrant -H node install.js
	 # cd /home/vagrant/IHaskell && ihaskell install
	 # gem install iruby  
	 ipython profile create iocaml
	 pip install redis_kernel 
	 pip install pandas boilerpipe bokeh feedparser nltk BeautifulSoup scipy scikit-learn PyOpenGL networkx
	 pip3 install pandas boilerpipe bokeh feedparser nltk BeautifulSoup scipy scikit-learn PyOpenGL networkx
	 chown vagrant:vagrant -R /home/vagrant/

	 # Start sequence for applications and node-red nodes    
	 su vagrant -c "cd /home/vagrant/ && nohup node-red > /home/vagrant/node-red.log 2>&1 &"
	 su vagrant -c "nohup rabbitmq-server > /home/vagrant/rabbitMQ.log 2>&1 &"
	 # Execute node-red setup
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-sqlite > /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-mysql >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-redis >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-xmpp >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-irc >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-stomp >> /home/vagrant/node-install.log"
	 pkill node-red ## Workaround to get node-red additional nodes activated
	 su vagrant -c "cd /home/vagrant/notebooks && nohup node-red > /home/vagrant/node-red.log 2>&1 &"
	 su vagrant -c "cd /home/vagrant/notebooks && nohup ipython notebook --ip=0.0.0.0 --no-browser > /home/vagrant/ipython.log 2>&1 &"
	 pkill ipython ## Workaround to get R kernel activated
	 # Activate R Kernel for iPython
	 su vagrant -c "cd /home/vagrant &&echo 'IRkernel::installspec()' |  R --no-save >> /home/vagrant/r_install.log 2>&1"
	 
	 # Add Python 3
	 sudo -H -u vagrant bash -c "ipython kernelspec install-self --user"
	 sudo -H -u vagrant bash -c "cp -R /home/vagrant/.ipython/kernels/python2/ /home/vagrant/.ipython/kernels/python3"
	 echo ' { "display_name": "Python 3",  ' > /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"language": "python", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"argv": [ ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"python3", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"-c", "from IPython.kernel.zmq.kernelapp import main; main()", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"-f", "{connection_file}"' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '], ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"codemirror_mode": {' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"version": 2, ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"name": "ipython"' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '}  }' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 chown vagrant:vagrant -R /home/vagrant/.ipython/kernels/
	 sudo -H -u vagrant bash -c "git clone https://github.com/matplotlib/matplotlib --depth=1"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/matplotlib && python3 setup.py build"
	 sudo cd /home/vagrant/ && python3 setup.py install
	 # Starting up some stuff
	 service mysql restart
	 su git -c "/etc/init.d/gitlab restart"
	 su vagrant -c "echo 'Access to gitlab: root, pass: 5iveL!fe' > /home/vagrant/readme.gitlab"
 
	 # Nearly finished, install some magic
	 su vagrant -c "mkdir -p /home/vagrant/magic"
	 su vagrant -c "cd /home/vagrant/ && git clone https://github.com/cjdrake/ipython-magic" # Graphviz Magics (gvmagic.py): %dot, %dotstr, %dotobj, %dotobjs
	 cd /home/vagrant/ipython-magic && python setup.py install
	 
	 ## Finish off - download some examples
	 mkdir -p /home/vagrant/notebooks/examples
	 mkdir -p /home/vagrant/notebooks/howto
	 mkdir -p /home/vagrant/notebooks/tests
	 mkdir -p /home/vagrant/notebooks/sample_data
	 cd /home/vagrant/notebooks/examples && wget http://jakevdp.github.io/mpl_tutorial/_downloads/01_basic_plotting.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/plotly/IPython-plotly/master/notebooks/survival_analysis/survival_analysis.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/bigsnarfdude/bsides_vancouver_2013/master/PickleRedis.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/DavidPowell/openmodes-examples/master/Using%20and%20creating%20geometric%20shapes.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/bokeh/bokeh-notebooks/master/tutorial/02%20-%20charts.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/ptwobrussell/Mining-the-Social-Web-2nd-Edition/master/ipynb/Chapter%205%20-%20Mining%20Web%20Pages.ipynb
	 cd /home/vagrant/notebooks/examples && wget http://jakevdp.github.com/downloads/notebooks/XKCD_plots.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/justmarkham/DAT4/master/notebooks/08_linear_regression.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/jrjohansson/ipython-asymptote/master/examples/asymptote_magic_examples.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/ipython-books/cookbook-code/master/notebooks/chapter06_viz/06_vispy.ipynb
	 # cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/mbakker7/exploratory_computing_with_python/master/notebook1/py_exploratory_comp_1_sol.ipynb
	 cd /home/vagrant/notebooks/ && git clone https://github.com/ipython/ipython-in-depth.git --depth=1
	 chown -R vagrant:vagrant /home/vagrant/

	 # Finally start ipython
	 su vagrant -c "cd /home/vagrant/notebooks && nohup ipython notebook --ip=0.0.0.0 --no-browser >> /home/vagrant/ipython.log 2>&1 &"

	 # python to show installed modules
	 # python -c 'import pip;  sorted(["%s==%s" % (i.key, i.version) for i in pip.get_installed_distributions()]);'
	 # python test for pyqt: from PyQt4 import QtCore, QtGui
	 # Info about gitlab: sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
	 # Info about back-ends: import matplotlib.rcsetup as rcsetup
     # print(rcsetup.all_backends

	 mkdir /mnt/share
	 mount -t vboxsf vagrant_data /mnt/share

 