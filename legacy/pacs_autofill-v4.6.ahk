#Requires AutoHotkey v2.0
#SingleInstance Force

; ========================================================
; PACS 一键回填、追加与收藏脚本 (pacs_autofill.ahk)
; 功能：
;   1. 【F10 全覆回填】：仅在 PACS（TechMain.exe）窗口中生效。
;      全选并覆盖「所见框」，跳至「结论框」全选并覆盖结论。
;      用于单部位或首个部位回填。
;   2. 【` 键 追加回填】（数字 1 左边的反引号键，SC029）：
;      仅在 PACS（TechMain.exe）窗口中生效，其他窗口照常打字。
;      不全选，在当前光标位置插入所见；跳到结论框末尾，换行接上结论。
;      用于胸腹等多部位报告追加，避免覆盖前一部位。
;   3. 【F9 收藏好报告】：全局快捷键（任意窗口均可按）。
;      将最近一次回填或追加的报告以相同格式追加到 D:\AI\好报告.md，
;      并在屏幕中央弹出持续 1 秒的「已收藏」提示。
;   4. 每次回填或追加自动记录至 D:\AI\报告记录.md。
;   5. 操作完成后自动恢复用户的原始剪贴板，不破坏后续复制粘贴。
; ========================================================

#Include clean_lib.ahk

A_IconTip := "PACS 报告回填 (F10 全覆 | `` 追加 | F9 收藏)"

; 全局变量：记录最近一次回填或追加的完整报告块
global g_LastReportBlock := ""

; 脚本启动时，尝试从已有的报告记录中恢复最后一条，防止重启后按 F9 丢失
InitLastReport()

InitLastReport() {
    global g_LastReportBlock
    recPath := "D:\AI\报告记录.md"
    if !FileExist(recPath)
        return
    try {
        content := FileRead(recPath, "UTF-8")
        pos := RTrim(content, "`r`n `t")
        lastIdx := InStr(pos, "`n## ",, -1)
        if (lastIdx > 0) {
            g_LastReportBlock := SubStr(pos, lastIdx + 1) . "`n`n"
        } else if (SubStr(pos, 1, 3) = "## ") {
            g_LastReportBlock := pos . "`n`n"
        }
    } catch {
        ; 读取异常时保持空
    }
}

; ========================================================
; PACS 专属热键区域（仅在 TechMain.exe 激活时生效）
; 其他窗口（浏览器、微信、Word 等）按 F10 或 ` 均保持原生行为
; ========================================================
#HotIf WinActive("ahk_exe TechMain.exe")

; --------------------------------------------------------
; 1. F10：全选覆盖回填（用于全新报告或单部位报告）
; --------------------------------------------------------
$F10:: {
    KeyWait "F10"

    ; 检查剪贴板内容
    clipText := A_Clipboard
    if (clipText = "") {
        ToolTip "【PACS回填】剪贴板为空！请先从报告点选网页复制报告。"
        SetTimer () => ToolTip(), -2000
        return
    }

    ; 清洗并拆分「所见」与「结论」
    result  := CleanAndSplit(clipText)
    suojian := result["suojian"]
    jielun  := result["jielun"]

    ; 转换换行为 CRLF（PACS 文本框需要）
    suojian := StrReplace(suojian, "`n", "`r`n")
    jielun  := StrReplace(jielun,  "`n", "`r`n")

    ; 记录至 D:\AI\报告记录.md
    LogReportRecord(clipText, suojian, jielun)

    ; 备份剪贴板并设置事件模式
    clipBackup := ClipboardAll()
    SendMode "Event"
    SetKeyDelay 40, 20

    ; 填入「所见框」（全选覆盖）
    A_Clipboard := suojian
    ClipWait 1
    Sleep 60
    SendEvent "^a"
    Sleep 80
    SendEvent "^v"
    Sleep 120

    ; 如果有「结论」，跳转并填入「结论框」（全选覆盖）
    if (jielun != "") {
        SendEvent "^{End}"
        Sleep 80
        SendEvent "^{Down}"
        Sleep 80
        SendEvent "^a"
        Sleep 80
        A_Clipboard := jielun
        ClipWait 1
        Sleep 60
        SendEvent "^v"
        Sleep 120
    }

    ; 恢复原始剪贴板
    Sleep 150
    A_Clipboard := clipBackup

    ; 提示
    if (jielun != "") {
        ToolTip "【PACS回填成功】已全覆填入所见与结论！已自动记入报告记录。按 F9 可收藏。"
    } else {
        ToolTip "【PACS回填成功】已全覆填入当前框！已自动记入报告记录。按 F9 可收藏。"
    }
    SetTimer () => ToolTip(), -2000
}

; --------------------------------------------------------
; 2. ` 键（数字 1 左边那颗键，SC029）：追加回填（用于多部位报告追加）
;    按下后不全选，在光标位置插入所见；跳到结论框末尾，换行接上结论。
; --------------------------------------------------------
$SC029::
$`:: {
    KeyWait "SC029"

    ; 检查剪贴板内容
    clipText := A_Clipboard
    if (clipText = "") {
        ToolTip "【PACS追加】剪贴板为空！请先从报告点选网页复制报告。"
        SetTimer () => ToolTip(), -2000
        return
    }

    ; 清洗并拆分「所见」与「结论」
    result  := CleanAndSplit(clipText)
    suojian := result["suojian"]
    jielun  := result["jielun"]

    ; 转换换行为 CRLF
    suojian := StrReplace(suojian, "`n", "`r`n")
    jielun  := StrReplace(jielun,  "`n", "`r`n")

    ; 记录至 D:\AI\报告记录.md
    LogReportRecord(clipText, suojian, jielun)

    ; 备份剪贴板并设置事件模式
    clipBackup := ClipboardAll()
    SendMode "Event"
    SetKeyDelay 40, 20

    ; 填入「所见框」（在当前光标位置插入，不全选覆盖）
    A_Clipboard := suojian
    ClipWait 1
    Sleep 60
    SendEvent "^v"
    Sleep 120

    ; 如果有「结论」，跳转到结论框末尾，换一行接上结论
    if (jielun != "") {
        ; 从所见框跳至结论框
        SendEvent "^{End}"
        Sleep 80
        SendEvent "^{Down}"
        Sleep 80

        ; 移到结论文本最末尾
        SendEvent "^{End}"
        Sleep 80

        ; 换一行
        SendEvent "{Enter}"
        Sleep 80

        ; 接上结论
        A_Clipboard := jielun
        ClipWait 1
        Sleep 60
        SendEvent "^v"
        Sleep 120
    }

    ; 恢复原始剪贴板
    Sleep 150
    A_Clipboard := clipBackup

    ; 提示
    if (jielun != "") {
        ToolTip "【PACS追加成功】已在光标处插入所见并追加结论！已自动记入报告记录。按 F9 可收藏。"
    } else {
        ToolTip "【PACS追加成功】已在光标处插入所见！已自动记入报告记录。按 F9 可收藏。"
    }
    SetTimer () => ToolTip(), -2000
}

#HotIf

; ========================================================
; 3. F9 收藏快捷键：全局生效（在哪个窗口里按都行）
;    将最近一次回填或追加的报告以相同格式追加进 D:\AI\好报告.md，
;    屏幕弹出 1 秒「已收藏」小提示
; ========================================================
#HotIf ; 清空条件，恢复为全局热键

$F9:: {
    global g_LastReportBlock
    if (g_LastReportBlock = "") {
        InitLastReport()
    }

    if (g_LastReportBlock = "") {
        ToolTip "【提示】尚未回填过任何报告，暂无可收藏内容"
        SetTimer () => ToolTip(), -1000
        return
    }

    try {
        FileAppend(g_LastReportBlock, "D:\AI\好报告.md", "`n UTF-8")
        ToolTip "已收藏"
    } catch as err {
        ToolTip "【收藏失败】" err.Message
    }
    SetTimer () => ToolTip(), -1000
}

#HotIf

; ========================================================
; 辅助函数：构造报告记录并写入 D:\AI\报告记录.md
; ========================================================
LogReportRecord(clipText, suojian, jielun) {
    global g_LastReportBlock

    currentTime := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    winTitle := WinGetTitle("A")
    if (winTitle = "") {
        try {
            winTitle := WinGetTitle("ahk_exe TechMain.exe")
        } catch {
            winTitle := "TechMain.exe"
        }
    }
    if (winTitle = "")
        winTitle := "PACS 工作站 (TechMain.exe)"

    recordBlock := "## " currentTime " | " winTitle "`n"
        . "- **时间**：" currentTime "`n"
        . "- **PACS 窗口标题**：" winTitle "`n"
        . "- **报告全文（原始）**：`n"
        . clipText "`n`n"
        . "- **清洗后所见**：`n"
        . suojian "`n`n"
        . "- **清洗后结论**：`n"
        . jielun "`n`n"
        . "---`n`n"

    try {
        FileAppend(recordBlock, "D:\AI\报告记录.md", "`n UTF-8")
    } catch as err {
        ; 记录文件异常不阻断主流程
    }

    g_LastReportBlock := recordBlock
}
