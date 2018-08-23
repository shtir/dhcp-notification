# Pushover account info
:local APIToken “”;
:local UserKey “”;

:local date [/system clock get date];
:local time [/system clock get time];
:local cname [/interface wireless registration-table get value-name=comment [find mac-address=$leaseActMAC]];
:if ( $cname = “” ) do={
:local hostname [/ip dhcp-server lease get value-name=host-name [find mac-address=$leaseActMAC]];
set cname “$hostname $leaseActMAC”;
}

/tool fetch http-method=post http-content-type=”application/json” http-data=”{\”token\”: \”$APIToken\”, \”user\”: \”$UserKey\”, \”message\”: \”$cname $leaseActIP $date $time\”}” url=”https://api.pushover.net/1/messages.json”
