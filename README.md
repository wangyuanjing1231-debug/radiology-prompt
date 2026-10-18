# radiology-prompt

放射科语音流报告的规矩仓库。借鉴 OpenClaw 工作区的分层：

| 层 | 文件 | 说明 |
|---|---|---|
| 核心规矩 | `prompt-en.md`（放进 Gemini 技能的版本）、`prompt.md`（中文对照） | 现行 v4.0。只有这一层同步给 Gemini |
| 候选经验 | `candidates.md` | 用的时候发现的问题和习惯写法，不同步；攒够、确认了再升级进核心规矩 |
| 工具 | `tools/baogao.html` | 点选网页：Ctrl+V 粘贴 Gemini 整条回复，点掉不要的，复制进 PACS |
| 记录 | （以后再建） | AI 初稿、自己改的、最终报告对照，用来反推规矩 |

分工：聊天里的 Claude 维护规矩和经验；YJW 上的 Antigravity 把核心规矩同步进 Gemini 技能并回读核对。

用法：Gemini 网页（Gemini 4），一个病人一个新对话，技能自动加载 → 回复下面的复制按钮 → 点选网页 → PACS。

v3.8 及以前的旧提示词在 `legacy/`，只作参考，不再使用。
