<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.135
	 Created on:   	2/17/2017 9:08 AM
	 Created by:   	dschauland
	 Organization: 	
	 Filename:     	INmanageActiveDirectory.psm1
	-------------------------------------------------------------------------
	 Module Name: INmanageActiveDirectory
	===========================================================================
#>



function add-INRemoteDesktopInfo
{
	param ($username,
		$ou,
		$homedriveletter,
		$homedirectory,
		$profilepath,
		[switch]$allowlogin
	)
	
	$name = Get-ADUser $username -Properties givenname, surname| select givenname,surname
	$first = $name.givenname
	$last = $name.surname
	
	
	$usercn = "CN=$first $last"
	$ou = [ADSI]"LDAP://$ou"
	$username = $ou.psbase.children().find($usercn)
	
	
	Write-Host "Updating Remote Desktop / Terminal Services Info for $user"
	
	
	
	if (!$allowlogin)
	{
		$username.psbase.invokeset("allowLogin", 1)
		
		if ($homedirectory)
		{
			$username.psbase.invokeset("TerminalServicesHomeDirectory", $homedirectory)
		}
		
		if ($profilepath)
		{
			$username.psbase.invokeset("TerminalServicesProfilePath", $profilepath)
		}
		
		if ($homedriveletter)
		{
			$username.psbase.invokeset("TerminalServicesHomeDrive", $homedriveletter)
		}
		
	}
	else
	{
		if ($homedirectory)
		{
			$username.psbase.invokeset("TerminalServicesHomeDirectory", $homedirectory)
		}
		
		if ($profilepath)
		{
			$username.psbase.invokeset("TerminalServicesProfilePath", $profilepath)
		}
		
		if ($homedriveletter)
		{
			$username.psbase.invokeset("TerminalServicesHomeDrive", $homedriveletter)
		}
	}
	
	$username.setinfo()
	
}

Export-ModuleMember -Function add-INRemoteDesktopInfo



