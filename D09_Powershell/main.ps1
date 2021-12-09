function Import-Data {
    <#
    .SYNOPSIS
        Loads data from the input file

    .RETURNS
        Data as a 2D array of integers
    #>
    [int[][]]$nums = @()

    foreach ($line in Get-Content .\input) {
        [int[]]$lineNums = @()

        foreach ($char in $line.ToCharArray()) {
            $lineNums += [int][char]$char - [int][char]'0'
        }

        $nums += , @($lineNums)
    }

    return $nums
}

class Position {
    <#
    .SYNOPSIS
        Position
    #>

    # Row
    [int]$row

    # Column
    [int]$col

    # Constructor
    Position([int] $row, [int] $col) {
        $this.row = $row
        $this.col = $col
    }

    static [Position] FromString([string] $str) {
        <#
        .SYNOPSIS
            Position from a string

        .RETURNS
            Position

        .PARAM $str
            String in the format "row,col"
        #>

        $elts = $str.Split(",")
        return [Position]::new([int] $elts[0], [int] $elts[1])
    }

    [string] ToString() {
        <#
        .SYNOPSIS
            String representation of the position

        .RETURNS
            String in the format "row,col"
        #>

        return "{0},{1}" -f $this.row, $this.col
    }

    [bool] Equals($other) {
        <#
        .SYNOPSIS
            Equality check

        .RETURNS
            True if the positions are equal, false otherwise

        .PARAM $other
            Position to compare to
        #>

        return ($this.row -eq $other.row) -and ($this.col -eq $other.col)
    }
}

function Invoke-Main {
    <#
    .SYNOPSIS
        Main function

    .DESCRIPTION
        Execute the two parts of the challenge

    .OUTPUTS
        Part 1 and 2 answers
    #>
    param ()

    [int[][]]$data = Import-Data

    Write-Output "Part 1:"
    $res = Invoke-Part1 $data
    Write-Output $res

    Write-Output "Part 2:"
    $res = Invoke-Part2 $data
    Write-Output $res

    Write-Output "OK"
}

. .\part1.ps1
. .\part2.ps1

Invoke-Main
