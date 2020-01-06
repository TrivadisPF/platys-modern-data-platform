<#

.SYNOPSIS
    Script to run the MDP Stack Generator with PowerShell

.DESCRIPTION
    This scrip runs the MDP Stack Generator. Docker has to be installed. And the target directory created

.PARAMETER defintion
    Custom values definition yml file 

.PARAMETER folder
    Folder where the result should be deployed (has to exists)
    
.PARAMETER version
    Version of the MDP Stack Generator to use.
    

.EXAMPLE 
    ./mdps-generate.ps1 -defintion '\config\custom.yml' -folder '\docker' -version "1.0.0"

#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [String]$defintion, 

    [Parameter(Mandatory=$true, Position=1)]
    [string]$folder, 

    [Parameter(Mandatory=$true, Position=2)]
    [String]$version
)

Write-Output "Running the Modern Data Platform Stack Generator ...."

docker run --rm -v ('"{0}:/tmp/custom-values.yml"' -f $defintion) -v ('"{0}:/opt/analytics-generator/stacks"' -f $folder)  ("trivadis/modern-data-platform-stack-generator:{0}" -f $version)

$dockerCompose = ("{0}/docker-compose.yml" -f  $folder)
(Get-Content -Path $dockerCompose -Raw) -replace "(?s)`r`n\s*$" | Set-Content $dockerCompose

Write-Output ('Modern Data Platform Stack generated successfully to {0}' -f  $folder)