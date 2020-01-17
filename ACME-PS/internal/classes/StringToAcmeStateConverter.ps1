class StringToAcmeStateConverter : System.Management.Automation.PSTypeConverter {
    [bool] CanConvertFrom([object] $object, [Type] $destinationType) {
        if($object -is [string]) {
            return Test-Path ([string]$object);
        }

        return $false;
    }

    [bool] CanConvertTo([object] $object, [Type] $destinationType) {
        return $false
    }

    [object] ConvertFrom([object] $sourceValue, [Type] $destinationType,
        [IFormatProvider] $formatProvider, [bool] $ignoreCase)
    {
        if($null -eq $sourceValue) { return $null; }

        if(-not $this.CanConvertFrom($sourceValue, $destinationType)) {
            throw [System.InvalidCastException]::new();
        }

        $paths = [AcmeStatePaths]::new($sourceValue);
        return [AcmeDiskPersistedState]::new($paths, $false, $true);
    }

    [object] ConvertTo([object] $sourceValue, [Type] $destinationType,
        [IFormatProvider] $formatProvider, [bool] $ignoreCase)
    {
        throw [System.NotImplementedException]::new();
    }
}