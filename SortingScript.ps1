function Group-Items {
    $NumberOfItems = (Get-ChildItem -Recurse -File).Length
    $ItemsSorted = 0
    Write-Progress -Id 0 -Activity "Sorting Items" -Status "$ItemsSorted out of $NumberOfItems" -PercentComplete (($ItemsSorted / $NumberOfItems) * 100)
    Get-ChildItem -Recurse -File | ForEach-Object {
        Write-Progress -Id 0 -Activity "Sorting Items" -Status "$ItemsSorted out of $NumberOfItems" -CurrentOperation $_.Name -PercentComplete (($ItemsSorted / $NumberOfItems) * 100)
        $Extension = $_.Extension.ToLower()
        $ListOfPictureExtensions = @(".png", ".jpg", ".jpeg")
        $ListOfVideoExtensions = @(".mov", ".mp4")
        if($ListOfPictureExtensions.Contains($Extension)) {
            $Extension = "Pictures"
        }
        if($ListOfVideoExtensions.Contains($Extension)) {
            $Extension = "Videos"
        }
        if($Extension.Length -eq 0) {
            $Extension = "NoExtension"
        }
        $DirPath = "C:\Users\Thomas\Desktop\SortedPhotos2\$($Extension)\$($_.LastWriteTime.Year.ToString())-$($_.LastWriteTime.Month.ToString())"
        if(-not (Test-Path -Path $DirPath)) {
            New-Item -ItemType Directory $DirPath
        }
        Copy-Item -Path $_.FullName -Destination $DirPath
        $ItemsSorted++
    }
    Write-Progress -Id 0 -Activity "Sorting Items" -Status "Complete!" -CurrentOperation "" -PercentComplete 100
}
