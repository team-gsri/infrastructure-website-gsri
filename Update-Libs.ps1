$LibsPath = Join-Path $PSScriptRoot "src/lib"
Remove-Item -Recurse -Force $LibsPath/*

& gh release download --repo twbs/bootstrap --pattern bootstrap-*-dist.zip --dir $LibsPath
& gh release download --repo FortAwesome/Font-Awesome --pattern fontawesome-free-*-web.zip --dir $LibsPath

Get-ChildItem $LibsPath -Filter *.zip | ForEach-Object {
    $_ | Expand-Archive -DestinationPath $LibsPath
}

$Files = @(
    'bootstrap.min.css'
    'bootstrap.min.css.map'
    'all.min.css'
    'fa-brands-400.woff2'
    'fa-solid-900.woff2'
)

Get-ChildItem $LibsPath -Recurse -Exclude $Files -File | ForEach-Object {
    $_ | Remove-Item
}

Remove-Item $LibsPath/*.zip