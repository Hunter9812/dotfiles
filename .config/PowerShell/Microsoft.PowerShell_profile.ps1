$OutputEncoding = [System.Console]::OutputEncoding = [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
Set-PSReadlineOption        -BellStyle None
Set-PSReadLineOption        -EditMode Emacs
Set-PSReadLineOption        -PredictionSource History
Set-PSReadlineKeyHandler    -Key Tab        -Function Complete
Set-PSReadLineKeyHandler    -Key "Alt+/"    -Function MenuComplete
Set-PSReadLineKeyHandler    -Key "Ctrl+z"   -Function Undo

#= Variable
$env:SHELL = "pwsh"
$env:EDITOR = "nvim"
$env:XDG_CONFIG_HOME = "$HOME/.config"
$env:XDG_CACHE_HOME = "$HOME/.cache"
$env:XDG_DATA_HOME = "$HOME/.local/share"
$env:XDG_STATE_HOME = "$HOME/.local/state"
$env:_ZO_DATA_DIR = "$HOME/.local/share"
$env:YAZI_CONFIG_HOME= "$HOME/.config/yazi"
$env:YAZI_FILE_ONE= "$HOME/scoop/apps/git/current/usr/bin/file.exe"
$env:JAVA_TOOL_OPTIONS = "-Dfile.encoding=UTF-8"
$env:RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env:RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$env:CARGO_UNSTABLE_SPARSE_REGISTRY = "true"

#= Alias & Function
#== Abbr
Set-Alias -Name poweroff    -Value Stop-Computer
Set-Alias -Name reboot      -Value Restart-Computer
Set-Alias -Name grep        -Value findstr
Set-Alias -Name open        -Value explorer
Set-Alias -Name s           -Value fastfetch
Set-Alias -Name vi          -Value nvim
function o { explorer . }
function c { code . }

#== Enhance
function ls { eza --color=auto --icons=auto --group-directories-first @args }
function la { eza --color=auto --icons=auto --group-directories-first --all --git @args }
function ll { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }
function l { eza --color=auto --icons=auto --group-directories-first --all --git --long @args }

#== Utils
function reload { pwsh -NoLogo; exit }
function conf { git --git-dir="$HOME/.cfg" --work-tree="$HOME" @Args }
function env { rundll32.exe sysdm.cpl,EditEnvironmentVariables }
function proxy {
	$env:HTTP_PROXY="http://127.0.0.1:11451"; $env:HTTPS_PROXY="http://127.0.0.1:11451";
    echo "已开启代理"
}
function unproxy {
    Remove-Item -Path env:HTTP_PROXY; Remove-Item -Path env:HTTPS_PROXY;
	echo "已关闭代理"
}
function cdw {
    param(
        [Parameter(Mandatory)]
        [string]$Target
    )

    # 1. command -> path
    $cmd = Get-Command $Target -ErrorAction SilentlyContinue

    if ($cmd -and $cmd.Path) {
        Set-Location (Split-Path -Parent $cmd.Path)
        return
    }

    # 2. file / directory
    if (Test-Path $Target) {
        $item = Get-Item -LiteralPath $Target

        if ($item.PSIsContainer) {
            Set-Location $item.FullName
        } else {
            Set-Location $item.Directory.FullName
        }

        return
    }

    Write-Error "不是一个有效的命令或路径: $Target"
}
function hideDotFiles {
    param (
        [string]$Path = $env:USERPROFILE
    )

    if (-Not (Test-Path $Path)) {
        Write-Error "指定的路径不存在: $Path"
        return
    }

    $dotItems = Get-ChildItem -Path $Path -Filter ".*" -Force

    foreach ($item in $dotItems) {
        $item.Attributes = [System.IO.FileAttributes]::Hidden
    }

    Write-Output "路径 $Path 中所有以点号开头的文件和文件夹已被隐藏。"
}
function unhideDotFiles {
    param (
        [string]$Path = $env:USERPROFILE
    )

    # 检查路径是否存在
    if (-Not (Test-Path $Path)) {
        Write-Error "指定的路径不存在: $Path"
        return
    }

    # 获取所有以点号开头的文件和文件夹，包括隐藏的
    $dotItems = Get-ChildItem -Path $Path -Filter ".*" -Force

    # 遍历并取消隐藏每个文件和文件夹
    foreach ($item in $dotItems) {
        # 检查当前项的属性
        if ($item.Attributes -band [System.IO.FileAttributes]::Hidden) {
            # 移除隐藏属性
            $item.Attributes = $item.Attributes -bxor [System.IO.FileAttributes]::Hidden
        }
    }

    Write-Output "路径 $Path 中所有以点号开头的文件和文件夹已取消隐藏。"
}
function convertWordToPdf {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourceFolder
    )

    # 获取桌面路径并设定目标目录
    $desktop = [Environment]::GetFolderPath("Desktop")
    $targetFolder = Join-Path $desktop "pdfs"

    # 创建目标目录（如不存在）
    if (!(Test-Path $targetFolder)) {
        New-Item -ItemType Directory -Path $targetFolder | Out-Null
    }

    # 启动 Word 应用
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false

    # 遍历 .doc / .docx 文件
    Get-ChildItem -Path $SourceFolder -File | Where-Object { $_.Extension -in ".doc", ".docx" } | ForEach-Object {
        $docPath = $_.FullName
        $pdfPath = Join-Path $targetFolder ($_.BaseName + ".pdf")

        Write-Host "正在转换：$($_.Name) -> $(Split-Path $pdfPath -Leaf)"

        $document = $word.Documents.Open($docPath, $false, $true)
        $document.SaveAs($pdfPath, 17)
        $document.Close($false)
    }

    # 退出 Word 并释放资源
    $word.Quit($false)
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
function mergePdfWithQpdf {
    param (
        [Parameter(Mandatory = $true)]
        [string]$sourceFolder,

        [string]$outputName = "merged.pdf"
    )

    # 确保路径为绝对路径
    $fullSourcePath = (Resolve-Path $sourceFolder).Path
    $outputPath = Join-Path $fullSourcePath $outputName

    # 获取按名称排序的 PDF 文件路径列表
    $pdfFiles = Get-ChildItem -Path $fullSourcePath -Filter *.pdf -File | Sort-Object Name

    if ($pdfFiles.Count -eq 0) {
        Write-Error "未找到 PDF 文件。"
        return
    }

    # 构造文件名参数列表
    $pdfList = $pdfFiles | ForEach-Object { "`"$($_.FullName)`"" }  # 注意加引号防止路径中有空格
    $pdfArgs = $pdfList -join " "

    # 构造完整命令字符串
    $command = "qpdf --empty --pages $pdfArgs -- `"$outputPath`""

    # Write-Host "执行命令：" $command
    Invoke-Expression $command
}
#=== Linux command
function which {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    $cmd = Get-Command $Command -ErrorAction SilentlyContinue

    if (-not $cmd) {
        return $null
    }

    switch ($cmd.CommandType) {
        'Application' { return $cmd.Path }
        'ExternalScript' { return $cmd.Path }
        'Alias' { return (Get-Command $cmd.Definition).Path }
        'Function' { return "(function) $($cmd.Name)" }
        default { return $cmd.Source ?? $cmd.Path }
    }
}
function source {
    param(
        [string]$Path
    )
    . $Path
}
function ln {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Target,

        [Parameter(Mandatory=$true)]
        [string]$Link,

        [switch]$s
    )

    if (-not (Test-Path $Target)) {
        Write-Error "目标路径 '$Target' 不存在。"
        return
    }

    if ($s) {
        # 符号链接（文件和目录都支持）
        New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
    } else {
        # 默认：硬链接（仅支持文件）
        if (Test-Path $Target -PathType Container) {
            Write-Error "Hard links can only be created for files."
            return
        }

        New-Item -ItemType HardLink -Path $Link -Target $Target | Out-Null
    }
}

#= Officially recommended
<# Import-Module "gsudoModule" #>
Invoke-Expression (&scoop-search --hook)
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

function y {
	$tmp = (New-TemporaryFile).FullName
	yazi.exe @args --cwd-file="$tmp"
	$cwd = Get-Content -Path $tmp -Encoding UTF8
	if ($cwd -and $cwd -ne $PWD.Path -and (Test-Path -LiteralPath $cwd -PathType Container)) {
		Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
	}
	Remove-Item -Path $tmp
}

$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression
