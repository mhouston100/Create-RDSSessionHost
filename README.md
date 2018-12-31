# Create-RDSSessionHost
Create a standalone, trial, RDS Session Host

#Purpose
We use these RDS Session hosts as testing platforms for application releases.

This script is run at the end of our SCCM OSD Task Sequence to create a session host. At the end of the testing the server is discarded.

#Keep in mind

A base session host has the following limitations:

* The certificates are self signed
* The license is 'trial' only, so cannot be used for production
* The license expires in 90 days

#Usage

In your MDT enabled SCCM TS, use the step 'Install Roles and Features'

Select the following features:

* Remote Desktop Connection Broker
* Remote Desktop Gateway
* Remote Desktop Licensing
* Remote Desktop Web Access

After the restart, implement a 'Run Powershell Script' step with :

Script Name:
Create-RDSSessionHost.ps1

Parameters:
-Password "somepassword"