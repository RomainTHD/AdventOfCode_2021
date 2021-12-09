class UnionFind {
    <#
    .SYNOPSIS
        Union-Find data structure
    #>

    # Representatives of the connected components
    hidden $_repr

    # Constructor
    UnionFind() {
        $this._repr = @{}
    }

    [void] Add([Position] $elem) {
        <#
        .SYNOPSIS
            Add an element to the data structure

        .PARAM $elem
            The element to add
        #>

        $this._repr[$elem.ToString()] = $elem
    }

    [Position] Find([Position] $elem) {
        <#
        .SEE
            Find
        #>

        return $this.Find($elem, $true)
    }

    hidden [Position] Find([Position] $elem, [bool] $compress) {
        <#
        .SYNOPSIS
            Find the representative of the connected component containing $elem

        .PARAM $elem
            The element to find the representative of

        .PARAM $compress
            Whether to compress the path to the representative

        .RETURN
            The representative of the connected component containing $elem
        #>

        [Position] $repr = $this._repr[$elem.ToString()]

        if ($repr -ne $elem) {
            $nRepr = $this.Find($repr, $compress)
            if ($repr -ne $nRepr -and $compress) {
                $this._repr[$elem.ToString()] = $nRepr
            }
            $repr = $nRepr
        }

        return $repr
    }

    [void] Union([Position] $elem1, [Position] $elem2) {
        <#
        .SYNOPSIS
            Union the connected components containing $elem1 and $elem2

        .PARAM $elem1
            The first element

        .PARAM $elem2
            The second element
        #>

        [Position] $repr1 = $this.Find($elem1)
        [Position] $repr2 = $this.Find($elem2)
        $this._repr[$repr1.ToString()] = $repr2
    }

   hidden [Position[]] FindAllTopLevelRepr() {
        <#
        .SYNOPSIS
            Find all the top-level representatives

        .RETURN
            The top-level representatives
        #>

        $fixed = $false
        $reprs = @()

        while (-not $fixed) {
            $fixed = $true
            $reprs = @()

            try {
                foreach ($key in $this._repr.Keys) {
                    [Position] $elem = [Position]::FromString($key)
                    [Position] $repr = $this.Find($elem, $false)
                    if ($elem -eq $repr) {
                        $reprs += $repr
                    }
                }
            } catch {
                $fixed = $false
            }
        }

        return $reprs
    }

    [System.Collections.Hashtable] FindAllElements() {
        <#
        .SYNOPSIS
            Find all the elements

        .RETURN
            The elements
        #>

        $reprs = $this.FindAllTopLevelRepr()
        $reprsItems = @{}

        foreach ($repr in $reprs) {
            $reprsItems[$repr.ToString()] = @()
        }

        foreach ($key in $this._repr.Keys) {
            $item = [Position]::FromString($key)
            [Position] $repr = $this.Find($item, $false)
            $reprsItems[$repr.ToString()] += $item
        }

        return $reprsitems
    }
}

function Invoke-Part2 {
    <#
    .SYNOPSIS
        Execute the second part of the challenge

    .PARAMETER data
        The data to use

    .RETURNS
        Part 2 answer
    #>

    param (
        # Data loaded from the input file
        [int[][]]
        $data
    )

    $uf = [UnionFind]::new()
    $INVALID_POS = [Position]::new(-1, -1)

    for ([int]$row = 0; $row -lt $data.Length; $row++) {
        for ([int]$col = 0; $col -lt $data[$row].Length; $col++) {
            $uf.Add([Position]::new($row, $col))
        }
    }

    $uf.add($INVALID_POS)

    for ([int]$row = 0; $row -lt $data.Length; $row++) {
        for ([int]$col = 0; $col -lt $data[$row].Length; $col++) {
            if ($data[$row][$col] -eq 9) {
                $uf.Union([Position]::new($row, $col), $INVALID_POS)
                continue
            }

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
                    $uf.Union([Position]::new($row, $col), [Position]::new($row + $offset.row, $col + $offset.col))
                }
            }
        }
    }

    $elements = $uf.FindAllElements()
    [System.Collections.ArrayList] $reprs = @()

    foreach ($repr in $elements.Keys) {
        if ($repr -ne $INVALID_POS) {
            [void] $reprs.Add($repr)
        }
    }

    $totalSize = 1

    for ($i = 0; $i -lt 3; $i++) {
        $maxIdx = -1
        $maxReprs = @()

        for ($j = 0; $j -lt $reprs.Count; $j++) {
            if ($elements[$reprs[$j].ToString()].Count -gt $maxReprs.Count) {
                $maxIdx = $j
                $maxReprs = $elements[$reprs[$j].ToString()]
            }
        }

        $totalSize *= $maxReprs.Count
        $reprs.RemoveAt($maxIdx)
    }

    return $totalSize
}
