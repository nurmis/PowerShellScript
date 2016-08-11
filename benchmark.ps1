# benchmark.psm1
# Exports: Benchmark-Command

function Benchmark-Command ([ScriptBlock]$Expression, [int]$Samples = 1) {
<#
.SYNOPSIS
  Runs the given script block and returns the execution duration.
  Hat tip to StackOverflow. http://stackoverflow.com/questions/3513650/timing-a-commands-execution-in-powershell
  
.EXAMPLE
  Benchmark-Command { ping -n 1 google.com }
#>
  $timings = @()
  [int]$Run = 1
  do {
    $sw = New-Object Diagnostics.Stopwatch
    $sw.Start()
    logman start mem
    $printout = & $Expression 2>&1
    logman stop mem
    $sw.Stop()
    $Run | Out-File c:\seleniumautomation\measurements\pythonfirefox.txt -Append
    $sw.Elapsed.TotalSeconds | Out-File c:\seleniumautomation\measurements\pythonfirefox.txt -Append
    $printout | Out-File c:\seleniumautomation\measurements\pythonfirefox.txt -Append
    $sw.Reset()
    $Samples--
    $Run++
  }
  while ($Samples -gt 0)
}

Export-ModuleMember Benchmark-Command