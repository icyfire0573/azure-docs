<#

.SYNOPSIS
 Modify file folder policy

.DESCRIPTION
 Modify file folder policy

.ROLE
Administrators

#>
param (
    [Parameter(Mandatory = $true)]
    [string[]]
    $filePath,
    [Parameter(Mandatory = $true)]
    [string[]]
    $daysOfWeek,
    [Parameter(Mandatory = $true)]
    [string[]]
    $timesOfDay,
    [Parameter(Mandatory = $true)]
    [int]
    $weeklyFrequency,

    [Parameter(Mandatory = $false)]
    [int]
    $retentionDays,

    [Parameter(Mandatory = $false)]
    [Boolean]
    $retentionWeeklyPolicy,
    [Parameter(Mandatory = $false)]
    [int]
    $retentionWeeks,

    [Parameter(Mandatory = $false)]
    [Boolean]
    $retentionMonthlyPolicy,
    [Parameter(Mandatory = $false)]
    [int]
    $retentionMonths,

    [Parameter(Mandatory = $false)]
    [Boolean]
    $retentionYearlyPolicy,
    [Parameter(Mandatory = $false)]
    [int]
    $retentionYears
)
Set-StrictMode -Version 5.0
$env:PSModulePath = (Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\Environment' -Name PSModulePath).PSModulePath
Import-Module MSOnlineBackup
$ErrorActionPreference = "Stop"
Try {
    $timesOfDaySchedule = @()
    foreach ($time in $timesOfDay) {
        $timesOfDaySchedule += ([TimeSpan]$time)
    }
    $daysOfWeekSchedule = @()
    foreach ($day in $daysOfWeek) {
        $daysOfWeekSchedule += ([System.DayOfWeek]$day)
    }

    $schedule = New-OBSchedule -DaysOfWeek $daysOfWeekSchedule -TimesOfDay $timesOfDaySchedule -WeeklyFrequency $weeklyFrequency
    if ($daysOfWeekSchedule.Count -eq 7) {
        if ($retentionWeeklyPolicy -and $retentionMonthlyPolicy -and $retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionWeeklyPolicy -and $retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths
        }
        elseif ($retentionWeeklyPolicy -and $retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionYearlyPolicy -and $retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionWeeklyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks
        }
        elseif ($retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths
        }
        elseif ($retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        else {
            $retention = New-OBRetentionPolicy -RetentionDays $retentionDays
        }
    }
    else {
        if ($retentionWeeklyPolicy -and $retentionMonthlyPolicy -and $retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionWeeklyPolicy -and $retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths
        }
        elseif ($retentionWeeklyPolicy -and $retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionYearlyPolicy -and $retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
        elseif ($retentionWeeklyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionWeeklyPolicy:$true -WeekDaysOfWeek $daysOfWeekSchedule -WeekTimesOfDay $timesOfDaySchedule -RetentionWeeks $retentionWeeks
        }
        elseif ($retentionMonthlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionMonthlyPolicy:$true -MonthDaysOfWeek $daysOfWeekSchedule -MonthTimesOfDay $timesOfDaySchedule -RetentionMonths $retentionMonths
        }
        elseif ($retentionYearlyPolicy) {
            $retention = New-OBRetentionPolicy -RetentionYearlyPolicy:$true -YearDaysOfWeek $daysOfWeekSchedule -YearTimesOfDay $timesOfDaySchedule -RetentionYears $retentionYears
        }
    }

    $oldPolicy = Get-OBPolicy
    if ($oldPolicy) {
        $ospec = Get-OBFileSpec $oldPolicy

        $p = Remove-OBFileSpec -FileSpec $ospec -Policy $oldPolicy -Confirm:$false

        $fileSpec = New-OBFileSpec -FileSpec $filePath

        Add-OBFileSpec -Policy $p -FileSpec $fileSpec -Confirm:$false
        Set-OBSchedule -Policy $p -Schedule $schedule -Confirm:$false
        Set-OBRetentionPolicy -Policy $p -RetentionPolicy $retention -Confirm:$false
        Set-OBPolicy -Policy $p -Confirm:$false
        $p
    }
    else {
        $policy = New-OBPolicy
        $fileSpec = New-OBFileSpec -FileSpec $filePath
        Add-OBFileSpec -Policy $policy -FileSpec $fileSpec
        Set-OBSchedule -Policy $policy -Schedule $schedule
        Set-OBRetentionPolicy -Policy $policy -RetentionPolicy $retention
        Set-OBPolicy -Policy $policy -Confirm:$false
    }
}
Catch {
    if ($error[0].ErrorDetails) {
        throw $error[0].ErrorDetails
    }
    throw $error[0]
}