#Requires AutoHotkey v2.0
; ============================================================
; clean_lib.ahk — PACS 报告清洗共享库
; 被 pacs_autofill.ahk 和 test_clean.ahk 通过 #Include 引用
; 与 baogao.html v4.6 body() / finalText() 函数逻辑保持一致
; ============================================================

StrJoin(arr, sep) {
    result := ""
    for i, v in arr {
        if (i > 1)
            result .= sep
        result .= v
    }
    return result
}

TrimLines(txt) {
    txt := RegExReplace(txt, "^\s*\n+", "")
    txt := RegExReplace(txt, "\n+\s*$", "")
    return Trim(txt, "`r`n `t　")
}

DropNoteLines(txt) {
    lines := StrSplit(txt, "`n")
    out := []
    for ln in lines {
        if !RegExMatch(ln, "^\s*(?:[-*•·>#]+\s*|\d+[.、．)）]\s*)*[▲★]")
            out.Push(ln)
    }
    return StrJoin(out, "`n")
}

StripConclusionPrefix(txt) {
    lines := StrSplit(txt, "`n")
    out := []
    ; 去除开头的序号（如 1. / 2、 / 3） / (1) / （1）及后面的空格），但排除 1.5cm 这类小数（小数点后紧跟数字不删）
    pat := "^[\s　]*(?:(?:\d+(?:[.\x{FF0E}](?!\d)|[、)）]))|[(（]\d+[)）])[ \t　]*"
    for ln in lines {
        out.Push(RegExReplace(ln, pat, ""))
    }
    return StrJoin(out, "`n")
}

; 按 baogao.html finalText() 规则：每个非空行去掉首尾空格（含全角空格），并在行首添加两个全角空格「　　」
IndentLines(txt) {
    lines := StrSplit(txt, "`n")
    out := []
    for ln in lines {
        t := RegExReplace(ln, "^[\s　]+|[\s　]+$", "")
        if (t != "") {
            out.Push("　　" . t)
        }
    }
    return StrJoin(out, "`n")
}

SplitReport(txt) {
    SEEN_PAT := "^(影像描述|影像表现|影像所见|检查所见|所见|描述)[:：]?\s*$"
    CONC_PAT := "^(结论|诊断意见|检查结论|诊断|印象)[:：]?\s*$"
    HEAD_PAT := "^(影像描述|影像表现|影像所见|检查所见|所见|描述|结论|诊断意见|检查结论|诊断|印象)[:：]?\s*$"

    lines := StrSplit(txt, "`n")

    hasHead := false
    for ln in lines {
        t := Trim(ln, " `t　`r`n")
        tClean := RegExReplace(t, "^(\d+[.、．]|[（(]\d+[)）])\s*", "")
        if RegExMatch(tClean, HEAD_PAT) {
            hasHead := true
            break
        }
    }

    suojian := ""
    jielun  := ""

    if hasHead {
        section   := 0
        seenLines := []
        concLines := []
        for ln in lines {
            t := Trim(ln, " `t　`r`n")
            tClean := RegExReplace(t, "^(\d+[.、．]|[（(]\d+[)）])\s*", "")
            if RegExMatch(tClean, SEEN_PAT) {
                section := 1
                continue
            }
            if RegExMatch(tClean, CONC_PAT) {
                section := 2
                continue
            }
            if (section = 1)
                seenLines.Push(ln)
            else if (section = 2)
                concLines.Push(ln)
        }
        suojian := StrJoin(seenLines, "`n")
        jielun  := StrJoin(concLines, "`n")
    } else {
        splitIdx := 0
        for i, ln in lines {
            if (Trim(ln, " `t　`r`n") = "") {
                splitIdx := i
                break
            }
        }
        if (splitIdx > 0) {
            seenLines := []
            concLines := []
            for i, ln in lines {
                if (i < splitIdx)
                    seenLines.Push(ln)
                else if (i > splitIdx)
                    concLines.Push(ln)
            }
            suojian := StrJoin(seenLines, "`n")
            jielun  := StrJoin(concLines, "`n")
        } else {
            suojian := txt
            jielun  := ""
        }
    }

    suojian := TrimLines(suojian)
    jielun  := TrimLines(jielun)
    jielun  := StripConclusionPrefix(jielun)

    ; 对所见和结论的每一个非空行执行缩进处理（行首两个全角空格）
    suojian := IndentLines(suojian)
    jielun  := IndentLines(jielun)

    return Map("suojian", suojian, "jielun", jielun)
}

CleanAndSplit(raw) {
    raw := StrReplace(raw, "`r`n", "`n")
    raw := StrReplace(raw, "`r",   "`n")
    raw := RegExReplace(raw, "\\([\[\]{}|*_#().!+\-])", "$1")
    raw := RegExReplace(raw, "\*\*", "")
    raw := RegExReplace(raw, "\[([^\[\]{}]*)\]", "$1")
    raw := RegExReplace(raw, "\{([^{}]*)\}",     "$1")

    ; 匹配 ``` 代码框：双引号内表示 3 个反引号需写 6 个反引号
    if RegExMatch(raw, "s)``````[^\n]*\n(.*?)``````", &mc) {
        inner := mc[1]
        inner := DropNoteLines(inner)
        return SplitReport(inner)
    }

    raw := DropNoteLines(raw)
    return SplitReport(raw)
}
