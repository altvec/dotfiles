-- Script to connect IPsec VPN and pass a password automagically!

tell application "System Events"
	-- get current clipboard contents as a string
	set CurrentClipboard to the clipboard as string
	
	-- set the clipboad to your password	
	set the clipboard to (do shell script "cat '" & "/Users/srg/Dropbox/Private/work_VPN_pwd.txt" & "'")
	
	-- start playing with the VPN
	tell current location of network preferences
		
		-- set the name of the VPN service from your Network Settings
		set VPNService to service "VPN (Cisco IPsec)"
		-- determine current VPN connection status
		set isConnected to connected of current configuration of VPNService
		
		-- if connected, then disconnect
		if isConnected then
			disconnect VPNService
			
			
		else -- otherwise, connect to the VPN
			
			connect VPNService
			
			-- wait 10 seconds before pasting in the password
			delay 10
			
			tell application id "com.apple.systemevents"
				-- paste clipboard contents into password box
				keystroke "v" using {command down}
				-- press "Enter"
				keystroke (key code 36)
				-- wait 10 seconds to connect
				delay 10
				-- determine current VPN connection status (after providing password)
				set nowConnected to connected of current configuration of VPNService
				
				-- if we're now connected ...
				if nowConnected then
					
					-- press "Enter" again to get rid of a dialog confirmation prompt, if one exists
					keystroke (key code 36)
					
					-- now, execute any other commands you want (ping a server to check its status, open mail, etc.)
					
				end if
			end tell
			
		end if
		
	end tell
	-- now reset the clipboard to what it was before we started
	set the clipboard to CurrentClipboard
end tell
