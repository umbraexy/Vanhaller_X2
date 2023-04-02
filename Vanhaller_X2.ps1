#2/23/23
#Created by umbraexy

Get-NetTCPConnection -State Listen, ESTABLISHED | Select-Object -Expandproperty OwningProcess | Sort-Object -Unique -OutVariable id | out-null;
$ciminfo= foreach ($line in $id) {
    if ($line -match $regex) {
        Get-CimInstance -Class Win32_Process | where-object PROCESSID -eq $line | Select-Object -Property ProcessId, ProcessName, CommandLine, Path, ParentProcessId, CreationDate
    }
};
$ciminfo > list_proc_cim_obj.txt;
$ciminfo | select-object -Expandproperty ProcessName | Get-Unique -AsString > list_proc_names.txt;