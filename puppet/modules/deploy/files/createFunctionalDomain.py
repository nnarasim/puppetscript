#############create_functional_domain.py##########
#!/usr/bin/python
import os, sys
createDomain('/opt/oracle/middleware/wlserver/common/templates/wls/wls.jar','/opt/oracle/middleware/user_projects/domains/functional-domain','weblogic','Dell_123$')
readDomain('/opt/oracle/middleware/user_projects/domains/functional-domain')
cd('/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(80)
cmo.setListenAddress('127.0.0.1')
print('Finalizing the changes')
updateDomain()
closeDomain()
exit()
#############E.O.F#############
