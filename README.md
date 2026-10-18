# radiology-prompt

放射科报告提示词仓库。

## 现行

- `prompt.md`：语音流报告规矩，v3.9 起（2026-10-19 启用）。用法：Gemini 网页里一个病人一个新对话，模型输出带 {选项|} 标记的文字，复制到点选网页 baogao.html，选完再复制进 PACS。规矩由聊天里的 Claude 维护，YJW 上的 Antigravity 负责同步进 Gemini 技能并回读核对。

## 旧时代（legacy/）

v3.8 及以前的提示词，只作参考思路，不再使用。和 v3.9 以后的版本不混在一起。

| 文件 | 内容 |
|---|---|
| voice-v1-zh.md / voice-v1-en.md | 语音流 v1，中文版和英文版：只写阳性，%% 标不确定 |
| voice-v3.md | 语音流 v3：▲ 分界推理阴性、【预警】栏、按需模板 |
| voice-v3.7.md | 语音流 v3.7 原版 |
| voice-v3.8.md | 语音流 v3.8，中文版和英文版 |
| image-v1.md | 图像 v1：看图直接出报告（幻觉高，已淘汰） |
| image-v2-zh.md / image-v2-en.md | 图像 v2：发图讨论，说"出报告"才出报告 |
