# Powershell ACH Totals
This script grabs various totals from a NACHA formatted ACH file and saves them into OpCon properties.  Comparisions can be done with these values and others to ensure the correct file is being processed.

# Prerequisites
  * Powershell 3+
  * OpCon MSLSAM v19+
  * OpCon Release v18.3+

# Instructions
This script can be run on a server or from the OpCon script repository.

 Parameters:
 
    * [string]$ACHFile (mandatory) - Path to ACH file
    * [string]$PropertyName (mandatory) - Property name for debit totals
    * [string]$PropertyName1 (mandatory) - Property name for credit totals
    * [string]$MsginPath (mandatory) - Path to MSLSAM MSGIN directory
    * [string]$MsginUser (mandatory) - User to use for MSGIN events
    * [string]$MsginPass (mandatory) - Password/Token for MSGIN events
    * [switch]$DebugMode - Option to only display what the OpCon event will be, does not send it to MSGIN

```
powershell.exe -ExecutionPolicy Bypass -File "c:\OpConACH.ps1" -ACHFile "C:\ProgramData\OpConxps\ACH.ach" -PropertyName "SI.Debit.[[$SCHEDULE DATE]].[[$SCHEDULE NAME]]" -PropertyName1 "SI.Credit.[[$SCHEDULE DATE]].[[$SCHEDULE NAME]]" -MsginPath "C:\ProgramData\OpConxps\MSLSAM\MSGIN" -MsginUser [[MSGINuser]] -MsginPass [[MSGINpass]]
```

# Disclaimer
No Support and No Warranty are provided by SMA Technologies for this project and related material. The use of this project's files is on your own risk.

SMA Technologies assumes no liability for damage caused by the usage of any of the files offered here via this Github repository.

# License
Copyright 2019 SMA Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing
We love contributions, please read our [Contribution Guide](CONTRIBUTING.md) to get started!

# Code of Conduct
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code-of-conduct.md)
SMA Technologies has adopted the [Contributor Covenant](CODE_OF_CONDUCT.md) as its Code of Conduct, and we expect project participants to adhere to it. Please read the [full text](CODE_OF_CONDUCT.md) so that you can understand what actions will and will not be tolerated.
