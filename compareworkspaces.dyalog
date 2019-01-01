:Class  CompareWorkspaces
⍝ User Command script for "Compare IWorkspaces"
⍝ Kai Jaeger
⍝ Version 1.4.1 from 2017-03-13

    ∇ r←List;⎕IO;⎕ML ⍝ this function usually returns 1 or more namespaces (here only 1)
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←⎕NS''                             ⍝ create the command
      r.Name←'CompareWorkspaces'   ⍝ the name
      r.Desc←'Compare Workspaces'
      r.Group←'APLTree'
     ⍝ Parsing rules for each:
      r.Parse←'0'              ⍝ takes 1 argument
    ∇

    ∇ r←Run(Cmd Args);browser;cmdparser;cs;ref;⎕IO;⎕ML;path;regKey;success;thisPath;filename;regData;paths
      :Access Shared Public
      ⎕IO←⎕ML←1
      r←''
      regKey←GetRegKey,'\Salt\CommandFolder'      
      regData←¯1 ReadRegKey regKey
      paths←¯1 ReadRegKey regKey     
      'Cannot find the SALT command folder in the Registry'⎕SIGNAL 11/⍨¯1≡paths
      ((paths∊'∘°')/paths)←';'
      paths←';'Split paths
      success←0
      :For thisPath :In paths
          filename←thisPath,'\CompareGUI.DWS'
          ⎕SE.⎕SHADOW'CompareGUI'
          'CompareGUI'⎕SE.⎕NS''
          :Trap 0
              ⎕SE.CompareGUI.⎕CY filename
              :If 0<1↑⍴⎕SE.CompareGUI.⎕NL⍳16
                  success←1
                  :Leave
              :EndIf
          :EndTrap
      :EndFor
      'Cannot find CompareGUI.DWS'⎕SIGNAL 11/⍨~success
      ⎕SE.CompareGUI.CompareGUI.Run ⍝ ref
    ∇

    ∇ r←Help Cmd;⎕IO;⎕ML;sep
      ⎕IO←⎕ML←1
      sep←⎕TC[3]
      :Access Shared Public
      r←'Fires up a GUI that allows you to specify two workspaces.',sep
      r,←'These two workspaces are then compared withe the class #.Compare. ',sep
    ∇

    ∇ r←{default}ReadRegKey key;wsh;⎕WX
     ⍝ Read a registry key. Uses a particular default path which can be _
     ⍝ overridden via the left argument
      :Access public shared
      ⎕WX←1
      default←{0<⎕NC ⍵:⍎⍵ ⋄ ''}'default'
      'wsh'⎕WC'OLEClient' 'WScript.Shell'
      :Trap 11
          r←wsh.RegRead key
      :Else
          r←default
      :EndTrap
    ∇

      Split←{
          ⎕ML←⎕IO←1
          ⍺←⎕UCS 13 10 ⍝ Default is CR+LF
          (⍴,⍺)↓¨⍺{⍵⊂⍨⍺⍷⍵}⍺,⍵
      }
      
      ∇ regKey←GetRegKey;⎕IO;⎕ML
      ⎕IO←⎕ML←1
      regKey←''
      regKey,←'HKEY_CURRENT_USER\Software\Dyalog\Dyalog APL/W'
      regKey,←('-64'≡¯3↑1⊃'.'⎕WG'APLVersion')/'-64'
      regKey,←' ',{⍵/⍨1≥+\'.'=⍵}2⊃'.'⎕WG'APLVersion'
      regKey,←' ',((80=⎕DR'')/'Unicode')
    ∇

:EndClass
