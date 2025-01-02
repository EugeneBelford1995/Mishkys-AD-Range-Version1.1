# Mishkys-AD-Range-Version1.1
Mishky's AD Range &amp; The Escalation Path from Hell, version 1.1

I tweaked the initial version of Mishky's AD Range (https://github.com/EugeneBelford1995/Mishkys-AD-Range). Changes include:

Better handling of function setting the VMs IP scheme, DNS, subnet, etc

Queries the host OS to see if it's on Windows 10/11 Pro vs Windows Server/Hyper-V Server and sets the vSW and RAM per VM accordingly

Changed up where I cached credentials on each VM in order to force range players to dump more potential sources

Added a VM running MSSQL to the second forest; Research.local (That forest is in our repo here:https://github.com/EugeneBelford1995/Mishkys-Range-Expansion-Pack-Version1.1 )

There likely will not be a version 1.2 unless I figure out how to work an Exchange Server into the range.


--- Using Mishky's AD Range ---

Run Pre-reqs.ps1 (creates folders to hold the range files, downloads a Windows Server 2022 ISO, sets up the vSW)

Run Create-Range.ps1 (spins up 4 VMs in parent & child domains, configs everything). Just hit Accept or Yes near the end, it prompts before grabbing & configuring a PS module.

Open up Hyper-V Manager, connect to each VM, and hit Enter. This will leave each VM sitting at a login screen instead a 'select keyboard layout' screen.

Spin up your Kali VM, run Responder, run Generate-Traffic.ps1, and start attacking the range.
