 <#
Purpose: To grab ACh Debits and Credits total from a file  and have it saved to a property 
Syntax: OpConACH.ps1 -ACHFile "C:\ProgramData\OpConxps\ACH.ach" -PropertyName "SI.Debit.[[$SCHEDULE DATE]].[[$SCHEDULE NAME]]" -PropertyName1 "SI.Credit.[[$SCHEDULE DATE]].[[$SCHEDULE NAME]]" -MsginPath "C:\ProgramData\OpConxps\MSLSAM\MSGIN" -MsginUser [[MSGINuser]] -MsginPass [[MSGINpass]]
Written By: David Cornelius
Tested: 20201013

ExitCode: 20 = Unable to reach the File Path
ExitCode: 30 = Unable to reach the MSGIN Path on the OpCon Server
ExitCode: 40 = Unable to find 9 record line
#>

param (
    [parameter(mandatory=$true)]
    [string]$ACHFile,
    [parameter(mandatory=$true)]
    [string]$PropertyName,
    [parameter(mandatory=$true)]
    [string]$PropertyName1,
    [parameter(mandatory=$true)]
    [string]$MsginPath,
    [parameter(mandatory=$true)]
    [string]$MsginUser,
    [parameter(mandatory=$true)]
    [string]$MsginPass,
    [switch]$DebugMode
)
 
$ErrorActionPreference = "Stop"

#Makes sure we can reach where the ACH file is saved
if(!(Test-Path $ACHFile))
{
    $rc = 20
    Write-output [$(Get-Date)]:"Unable to access $ACHFile -RC =$rc"
    [Environment]::Exit($rc)
}

#Makes sure we can reach OpCon MSGIN Path
if(!(Test-Path $MsginPath))
{
    $rc = 30
    Write-output [$(Get-Date)]:"Unable to access $MsginPath -RC =$rc"
    [Environment]::Exit($rc)
}

#Grabs ACH9 Record line and displays
$ACH9Record = ((Select-String -Path $ACHFile -Pattern ^9).Line -split ":")

if(!$ACH9Record)
{   
    $rc = 40
    Write-Output [$(Get-Date)]:"Unable to find 9 record in $ACHFile -RC =$rc"
    [Environment]::Exit($rc)
}
else
{ $ACH9Record }

#Grabs Debit Totals and displays
$Debit = $ACH9Record[0].Substring(31,12)
$Debit

#Trims leding Zeros and displays
$DebitNoZero =$Debit.TrimStart('0')
$DebitNoZero

#Grabs Credit Totals and displays
$Credit = $ACH9Record[0].Substring(43,12)
$Credit

#Trims leading Zeros and displays
$CreditNoZero =$Credit.TrimStart('0') 
$CreditNoZero

#If Debug is enabled, only output the event, otherwise write it to OpCon MSGIN
if($DebugMode)
{ 
     Write-Output "`$PROPERTY:ADD,$PropertyName,$DebitNoZero,$MsginUser,$MsginPass" 
     Write-Output "`$PROPERTY:ADD,$PropertyName1,$CreditNoZero,$MsginUser,$MsginPass"
}
else
{ 
     Write-Output "`$PROPERTY:ADD,$PropertyName,$DebitNoZero,$MsginUser,$MsginPass" | Out-File -encoding ascii "$MsginPath\Event$((get-date).ToString("hhmm")).txt" 
     Write-Output "`$PROPERTY:ADD,$PropertyName1,$CreditNoZero,$MsginUser,$MsginPass" | Out-File -encoding ascii "$MsginPath\Event$((get-date).ToString("hhmmss")).txt"
}