# CompareGUI

## Overview

`CompareGUI` is a comparison utility designed to compare Dyalog workspaces; This a Windows-only tool.

CompareGUI is a workspace that contains the code needed by the 

```
]CompareWorkpaces
``` 

user command. It requires an external comparison utility. 

If the user command `]CompareFiles` is available then it is used.

It offers a GUI with a list of all objects only contained in the first or only contained in the second workspace, and a list of all objects that exist in both workspaces but are different. Those can be compared from the list one-by-one.

You can also ask for a report on all differences in a single document via the "Report > Diffs" menu command.


## Installation

With version 4.0.0 `CompareGUI` became a Tatin package. In order to install it as a user command execute this:

```
]Tatin.InstallPackages [tatin]CompareGUI [MyUCMDs]
```

**Note:** if you have installed an earlier version remove it first.