# Add /opt/jdk1.8.0_112/bin to the path for sh compatible users

if ! echo $JAVA_HOME | grep -q /opt/jdk1.8.0_112 ; then
  export JAVA_HOME=$JAVA_HOME:/opt/jdk1.8.0_112
fi

if ! echo $PATH | grep -q /opt/jdk1.8.0_112/bin ; then
  export PATH=$PATH:/opt/jdk1.8.0_112/bin
fi
