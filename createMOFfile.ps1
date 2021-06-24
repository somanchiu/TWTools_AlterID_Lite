$data=Get-WmiObject Win32_ComputerSystemProduct

$Caption=$data.Caption
$Description=$data.Description
$IdentifyingNumber=$data.IdentifyingNumber
$Name=$data.Name
$SKUNumber=$data.SKUNumber
$Vendor=$data.Vendor
$Version=$data.Version
$UUID=(New-Guid).Guid

$mofFileName = 'changeUUID.mof'

"#pragma autorecover
#pragma namespace(""\\\\.\\Root\\CIMV2"")
class Win32_ComputerSystemProduct : CIM_Product
{[Read : ToSubclass,MappingStrings{""SMBIOS|Type 1|UUID""} : ToSubclass] String UUID;};
instance of Win32_ComputerSystemProduct
{
Caption=""$Caption"";
Description=""$Description"";
IdentifyingNumber=""$IdentifyingNumber"";
Name=""$Name"";
SKUNumber=""$SKUNumber"";
Vendor=""$Vendor"";
Version=""$Version"";
UUID=""$UUID"";
};" > $mofFileName