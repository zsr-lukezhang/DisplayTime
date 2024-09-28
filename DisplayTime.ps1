Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 检查并添加 Windows API 函数
if (-not ([System.Management.Automation.PSTypeName]'User32').Type) {
    Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr GetWindowLongPtr(IntPtr hWnd, int nIndex);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr SetWindowLongPtr(IntPtr hWnd, int nIndex, IntPtr dwNewLong);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetLayeredWindowAttributes(IntPtr hwnd, uint crKey, byte bAlpha, uint dwFlags);
}

public class Dwmapi {
    [DllImport("dwmapi.dll", PreserveSig = false)]
    public static extern void DwmExtendFrameIntoClientArea(IntPtr hwnd, ref MARGINS pMarInset);

    [StructLayout(LayoutKind.Sequential)]
    public struct MARGINS {
        public int cxLeftWidth;
        public int cxRightWidth;
        public int cyTopHeight;
        public int cyBottomHeight;
    }
}
"@
}

# 设置应用程序为 DPI 感知
if (-not ([System.Management.Automation.PSTypeName]'DPIHelper').Type) {
    Add-Type @"
using System;
using System.Runtime.InteropServices;

public class DPIHelper {
    [DllImport("user32.dll")]
    public static extern bool SetProcessDPIAware();
}
"@
}
[DPIHelper]::SetProcessDPIAware()

$form = New-Object System.Windows.Forms.Form
$form.Text = "Time Display"
$form.Size = New-Object System.Drawing.Size(800, 300)  # 调整宽度为800
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MinimizeBox = $true  # 启用最小化按钮
$form.MaximizeBox = $true  # 启用最大化按钮

# 设置窗体图标
$iconPath = "C:\Users\Luke\OneDrive - Loading\Pictures\Win11UI\Program.ico"
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
$form.Icon = $icon

# 创建一个半透明的面板
$panel = New-Object System.Windows.Forms.Panel
$panel.Dock = [System.Windows.Forms.DockStyle]::Fill
$panel.BackColor = [System.Drawing.Color]::FromArgb(128, 0, 0, 0)  # 半透明黑色背景
$form.Controls.Add($panel)

# 创建一个标签来显示时间
$label = New-Object System.Windows.Forms.Label
$label.Size = New-Object System.Drawing.Size(800, 300)  # 调整宽度为800
$label.Font = New-Object System.Drawing.Font("Cascadia Code", 72, [System.Drawing.FontStyle]::Bold)
$label.ForeColor = [System.Drawing.Color]::White
$label.TextAlign = "MiddleCenter"
$panel.Controls.Add($label)

# 创建一个关闭按钮
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = "X"
$closeButton.Size = New-Object System.Drawing.Size(40, 40)
$closeButton.Location = New-Object System.Drawing.Point(750, 10)  # 调整位置
$closeButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$closeButton.ForeColor = [System.Drawing.Color]::White
$closeButton.BackColor = [System.Drawing.Color]::Red
$closeButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$closeButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$closeButton.Add_Click({ $form.Close() })
$closeButton.Visible = $false  # 隐藏关闭按钮
$form.Controls.Add($closeButton)

# 创建一个最小化按钮
$minimizeButton = New-Object System.Windows.Forms.Button
$minimizeButton.Text = "_"
$minimizeButton.Size = New-Object System.Drawing.Size(40, 40)
$minimizeButton.Location = New-Object System.Drawing.Point(700, 10)  # 调整位置
$minimizeButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$minimizeButton.ForeColor = [System.Drawing.Color]::White
$minimizeButton.BackColor = [System.Drawing.Color]::Gray
$minimizeButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$minimizeButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$minimizeButton.Add_Click({ $form.WindowState = 'Minimized' })
$minimizeButton.Visible = $false  # 隐藏最小化按钮
$form.Controls.Add($minimizeButton)

# 创建一个最大化按钮
$maximizeButton = New-Object System.Windows.Forms.Button
$maximizeButton.Text = "□"
$maximizeButton.Size = New-Object System.Drawing.Size(40, 40)
$maximizeButton.Location = New-Object System.Drawing.Point(650, 10)  # 调整位置
$maximizeButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$maximizeButton.ForeColor = [System.Drawing.Color]::White
$maximizeButton.BackColor = [System.Drawing.Color]::Gray
$maximizeButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$maximizeButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$maximizeButton.Add_Click({
    if ($form.WindowState -eq 'Normal') {
        $form.WindowState = 'Maximized'
    } else {
        $form.WindowState = 'Normal'
    }
})
$maximizeButton.Visible = $false  # 隐藏最大化按钮
$form.Controls.Add($maximizeButton)

$form.Controls.SetChildIndex($closeButton, 0)  # 确保按钮在最前面
$form.Controls.SetChildIndex($minimizeButton, 0)  # 确保按钮在最前面
$form.Controls.SetChildIndex($maximizeButton, 0)  # 确保按钮在最前面

# 创建一个定时器来更新时间
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000  # 每秒更新一次
$timer.Add_Tick({
    $label.Text = (Get-Date).ToString("HH:mm:ss")
})
$timer.Start()

# 窗体大小改变事件处理
$form.Add_SizeChanged({
    $label.Size = $form.ClientSize
})

$form.FormClosing.Add({
    $timer.Stop()
    $timer.Dispose()
})

# 设置云母效果
$form.Load.Add({
    $hwnd = $form.Handle
    $margins = New-Object Dwmapi+MARGINS
    $margins.cxLeftWidth = -1
    $margins.cxRightWidth = -1
    $margins.cyTopHeight = -1
    $margins.cyBottomHeight = -1
    [Dwmapi]::DwmExtendFrameIntoClientArea($hwnd, [ref]$margins)
})

# 保存原始窗口大小和位置
$originalSize = $form.Size
$originalLocation = $form.Location

# 添加按键事件处理程序
$form.Add_KeyDown({
    param($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::F11) {
        if ($form.FormBorderStyle -eq [System.Windows.Forms.FormBorderStyle]::None) {
            $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
            $form.WindowState = 'Normal'
            $form.Size = $originalSize
            $form.Location = $originalLocation
            $form.TopMost = $false
        } else {
            $originalSize = $form.Size
            $originalLocation = $form.Location
            $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
            $form.WindowState = 'Normal'
            $form.TopMost = $true
            $form.Bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        }
    }
})

# 确保窗体能够接收按键事件
$form.KeyPreview = $true

[void]$form.ShowDialog()
