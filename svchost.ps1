# Obtén la cantidad total de RAM en GB
$RAM_GB = [math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB)

# Determinar el valor basado en la RAM
switch ($RAM_GB) {
    4 { $ValorRegistro = 68764420 }   # 4 GB
    8 { $ValorRegistro = 137922056 }  # 8 GB
    16 { $ValorRegistro = 376926742 }  # 16 GB
    32 { $ValorRegistro = 861226034 }  # 32 GB
    default { 
        $ValorRegistro = 0 
        Write-Host "La cantidad de RAM no está en las opciones definidas." -ForegroundColor Yellow
    }
}

# Ruta del registro
$RutaRegistro = "HKLM:\SYSTEM\ControlSet001\Control"

# Modificar el valor del registro
try {
    Set-ItemProperty -Path $RutaRegistro -Name "SvcHostSplitThresholdInKB" -Value $ValorRegistro -Type DWord
    Write-Host "El valor de SvcHostSplitThresholdInKB se ha actualizado a $ValorRegistro." -ForegroundColor Green
} catch {
    Write-Host "Error al modificar el registro: $_" -ForegroundColor Red
}


