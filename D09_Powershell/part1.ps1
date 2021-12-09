function Invoke-Part1 {
    <#
    .SYNOPSIS
        Execute the first part of the challenge

    .PARAMETER data
        The data to use

    .RETURNS
        Part 1 answer
    #>

    param (
        # Data loaded from the input file
        [int[][]]
        $data
    )

    [int]$riskLevel = 0

    for ([int]$row = 0; $row -lt $data.Length; $row++) {
        for ([int]$col = 0; $col -lt $data[$row].Length; $col++) {
            [bool]$isMin = $true

            $offsets = @(
                [Position]::new(1, 0),
                [Position]::new(0, 1),
                [Position]::new(-1, 0),
                [Position]::new(0, -1)
            )

            foreach ($offset in $offsets) {
                if ($row + $offset.row -lt 0 -or $row + $offset.row -ge $data.Length -or
                    $col + $offset.col -lt 0 -or $col + $offset.col -ge $data[$row].Length) {
                    continue
                }

                if ($data[$row + $offset.row][$col + $offset.col] -le $data[$row][$col]) {
                    $isMin = $false
                    break
                }
            }

            if ($isMin) {
                $riskLevel += $data[$row][$col] + 1
            }
        }
    }

    return $riskLevel
}
