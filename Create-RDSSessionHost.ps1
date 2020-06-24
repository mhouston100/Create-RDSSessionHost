<#	
	.NOTES
	===========================================================================
	 Created on:   	29/12/2018 2:45 PM
	 Created by:   	Matt Houston
	 Organization: 	
	 Filename:		Creat-RDSSessionHost
	===========================================================================
	.DESCRIPTION
		Run this on a Windows Server install to convert to an RDS Session host (stand alone)
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param (
	[parameter(Mandatory = $true, HelpMessage = "Enter a password used for the creation of the RDS Certificates")]
	[ValidateNotNullOrEmpty()]
	[string]$Password
)

Import-Module RemoteDesktop

$Hostname = "$($env:COMPUTERNAME)"
$convPassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

Write-Output "Creating RDS Session Deployment"
New-RDSessionDeployment -ConnectionBroker $hostname -WebAccessServer $hostname -SessionHost $hostname
Write-Output "Completed RDS Session Deployment"
# Start-Sleep -Seconds 15

Write-Output "Creating RDS Session Collection"
New-RDSessionCollection -CollectionName "$($Hostname).RDS.ENV" -SessionHost $hostname -CollectionDescription "$($Hostname).RDS.ENV" -ConnectionBroker $hostname
Write-Output "Completed RDS Session Collection"

Write-Output "Creating RDS Certificates"
New-RDCertificate -Role RDPublishing -DnsName $hostname -Password $convPassword -ConnectionBroker $hostname -force

New-RDCertificate -Role RDWebAccess -DnsName $hostname -Password $convPassword -ConnectionBroker $hostname -Force

New-RDCertificate -Role RDRedirector -DnsName $hostname -Password $convPassword -ConnectionBroker $hostname -Force

Write-Output "Completed RDS Certificates"
