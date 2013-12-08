[xml]$vcroj = Get-Content "C:\dev\guitarpro7\Shared\guitarpro\msvc\guitarpro\bk.xml"
$ns = new-object Xml.XmlNamespaceManager $vcroj.NameTable
$ns.AddNamespace('n', 'http://schemas.microsoft.com/developer/msbuild/2003')
$excludes = $vcroj.SelectNodes("//n:ExcludedFromBuild", $ns)

#//'$(Configuration)|$(Platform)'=='Release|Win32'

$clcompiles =  New-Object Collections.ArrayList
$values =  New-Object Collections.ArrayList
foreach($exclude in $excludes)
{
    if($exclude.Condition.Contains("Debug"))
    {
        
        if($clcompiles.Contains($exclude.ParentNode))
        {
        }else
        {
            $values += $exclude.'#text';
            $clcompiles += $exclude.ParentNode
        }
    }
    $exclude.ParentNode.RemoveChild($exclude)
}
$i = 0
foreach($cl in $clcompiles)
{
    $exclude = $vcroj.CreateElement('ExcludedFromBuild')
    $text = $vcroj.CreateTextNode($values[$i])
    $exclude.AppendChild($text)
    $cl.AppendChild($exclude)
    $i++
}
$vcroj.Save("c:\tmp\bk2.xml")