# DisplayTime

A program written in `PowerShell`.

[Chinese README 中文说明](https://github.com/zsr-lukezhang/DisplayTime/blob/main/Guidelines/README_zh_CN.md)

## What can it do?

Displays the current system time with an accuracy of less than 1 second.

## What do you need?

- A new version of `Microsoft PowerShell`.
 - How to check if your `PowerShell` meets the requirements?
 - Press Windows+R to open "Run".
 - Type `pwsh`.
 - Press `Enter`.
 - If the PowerShell window opens, congratulations, no need to install again; if there is an error, please install the latest version of `PowerShell` from the [`Microsoft Store`](https://apps.microsoft.com/detail/9mz1snwt0n5d) or [`GitHub`](https://github.com/PowerShell/PowerShell/releases/latest).

## How to use?

- Download the latest version from the [`Releases`](https://github.com/zsr-lukezhang/DisplayTime/releases/latest) page on `GitHub`.
- Place this `ps1` file wherever you like.
- Press `Windows`+`R` to open "Run".
- Type `pwsh`.
- Press `Enter`.
- Use the `cd` command to navigate to the location where you placed the file.
  For example, if I placed it in `C:\Users\Luke\Programs\`, use the command:
  `cd C:\Users\Luke\Programs\`
- Alternatively, without using `cd`, directly use the command:
  `C:\Users\Luke\Programs\DisplayTime.ps1`
This should start the program.  
If there are errors, ignore them. That's normal. However, if it crashes, please email `admin@lukezhang.win` to submit a bug.

## Beautification Guide

Use `MicaForEveryone` to add rules as shown in the picture.  
![Mica For Everyone](https://github.com/user-attachments/assets/91dcf9a7-70cf-4399-a284-cded5fe4358a)

Change the code's `$iconPath = "C:\Users\Luke\OneDrive - Loading\Pictures\Win11UI\Program.ico"` to another path to customize the icon. If you keep this setting, note that it will display a blank file icon.

## Shortcut Guide

- Use `F11` to toggle full screen.

## Acknowledgements

- Microsoft Copilot helped me complete part of the code.
