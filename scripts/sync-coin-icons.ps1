# Sync a minimal coin icon set into coins/ for GitHub Pages CDN.
# Resizes to 128x128 PNG (Icon Manager contract in mmb app/components/icon-manager-modal-body.js).

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

function Export-CoinIcon {
    param(
        [Parameter(Mandatory = $true)][string]$SourceUrl,
        [Parameter(Mandatory = $true)][string]$DestPath
    )

    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add('User-Agent', 'MMB-coin-icon-sync/1.0')
    $bytes = $wc.DownloadData($SourceUrl)
    $ms = New-Object System.IO.MemoryStream(,$bytes)
    $img = [System.Drawing.Image]::FromStream($ms)
    $bmp = New-Object System.Drawing.Bitmap 128, 128
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::Transparent)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $scale = [Math]::Min(128 / $img.Width, 128 / $img.Height)
    $w = [int]($img.Width * $scale)
    $h = [int]($img.Height * $scale)
    $x = [int]((128 - $w) / 2)
    $y = [int]((128 - $h) / 2)
    $g.DrawImage($img, $x, $y, $w, $h)
    $g.Dispose()
    $img.Dispose()
    $ms.Dispose()

    $dir = Split-Path $DestPath -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }

    $bmp.Save($DestPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output ("Wrote {0} ({1} bytes)" -f $DestPath, (Get-Item $DestPath).Length)
}

$repoRoot = Split-Path $PSScriptRoot -Parent
$coinsDir = Join-Path $repoRoot 'coins'

$canonical = [ordered]@{
    cardano    = 'https://coin-images.coingecko.com/coins/images/975/large/cardano.png?1696502090'
    celestia   = 'https://coin-images.coingecko.com/coins/images/31967/large/tia.jpg?1696530772'
    dogwifcoin = 'https://coin-images.coingecko.com/coins/images/33566/large/dogwifhat.jpg?1702499428'
}

$tickerAliases = [ordered]@{
    ada = 'cardano'
    tia = 'celestia'
    wif = 'dogwifcoin'
}

foreach ($entry in $canonical.GetEnumerator()) {
    $dest = Join-Path $coinsDir ("{0}.png" -f $entry.Key)
    Export-CoinIcon -SourceUrl $entry.Value -DestPath $dest
}

foreach ($entry in $tickerAliases.GetEnumerator()) {
    $src = Join-Path $coinsDir ("{0}.png" -f $entry.Value)
    $dest = Join-Path $coinsDir ("{0}.png" -f $entry.Key)
    Copy-Item -Path $src -Destination $dest -Force
    Write-Output ("Alias {0} -> {1}" -f $entry.Key, $entry.Value)
}

Write-Output 'Done. Verify with: node (from mmb) scripts/tooling/test-icon-urls.js'
