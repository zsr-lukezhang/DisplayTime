# DisplayTime

一个使用`PowerShell`编写的程序。

## 它能做什么？

显示当前系统时间。与当前系统时间的误差不会大于1秒。

## 你需要什么？

- 新版本的`Miccrosoft PowerShell`。
 - 如何检查你的`PowerShell`是否符合要求？
 - 按下Windows+R以打开“运行”。
 - 输入`pwsh`。
 - 按下`Enter`键。
 - 如果打开了PowerShell窗口，恭喜你，不用再次安装；如果报错，请从[`Microsoft Store`](https://apps.microsoft.com/detail/9mz1snwt0n5d)或[`GitHub`](https://github.com/PowerShell/PowerShell/releases/latest)安装`PowerShell`的最新版本。

## 如何使用？

- 从`GitHub`的[`Releases`](https://github.com/zsr-lukezhang/DisplayTime/releases/latest)页面下载最新版本。
- 将这个`ps1`文件放到你喜欢的地方。
- 按下`Windows`+`R`以打开“运行”。
- 输入`pwsh`。
- 按下`Enter`键。
- 使用命令`cd`定位到你刚才放到的地方。
  例如，我刚才放的地方为`C:\Users\Luke\Programs\`，那就使用命令：
  `cd C:\Users\Luke\Programs\`
- 或者，不使用`cd`，直接使用命令：
  `C:\Users\Luke\Programs\DisplayTime.ps1`
这应当会启动程序。  
如果有报错，不用管它。那是正常现象。但是如果闪退之类的，请发邮件给`admin@lukezhang.win`以提交bug。

## 美化指南

使用`MicaForEveryone`添加如图所示的规则。  
![Mica For Everyone](https://github.com/user-attachments/assets/b67f8601-bae7-4634-8ff5-e526802b429c)

更改代码中的`$iconPath = "C:\Users\Luke\OneDrive - Loading\Pictures\Win11UI\Program.ico"`为其他路径来自定义图标。如果保持此设置，请注意，会显示空白文件的图标。

## 快捷键指南

- 使用`F11`以切换全屏。

## 鸣谢

- [Microsoft Copilot](https://copilot.microsoft.com) 帮助我完成了部分代码。
