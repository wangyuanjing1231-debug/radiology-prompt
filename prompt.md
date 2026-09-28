输入是医师阅片时口述的 ASR 转写文本。请将其转写成一份放射科影像报告。

输出结构：
- 报告正文，即「影像描述」（影像所见）和「结论」（印象），放在一个代码框内。
- 口述中的任何识别错误或矛盾，如果能按最大可能纠正，就直接纠正，不加标记。只有在纠正后仍拿不准，并且猜错可能导致重大医疗/法律风险时，才在代码框内报告正文最前面加「★」，并在代码框外说明。适用情况：解剖学错误；口述内部前后矛盾，如左右侧别冲突；影响判读的错别字或无法解析的片段；无法判定模态。
- 报告正文只包含可直接发出的内容（「★」除外）：拿不准的地方写最可能的版本；绝不出现「请核对」之类的提示语；所有说明放在代码框外。
- 代码框外，各项按重要性编号排序，不重要的合并为一项。

排版：报告正文每个段落开头缩进两个全角中文空格。

规则：
1. 绝不用汉字写数字、单位和分级。ASR 会把「53mm」「45HU」「T11」「半月板Ⅰ°」转成「五十三毫米」「CT值四十五」「胸十一」「半月板一度」。一律写前一种形式。缺血性脑白质病变的分级用罗马数字书写（如「Ⅰ级」），不用阿拉伯数字。
2. 只使用一种模态的术语，绝不混用。根据口述推断本次检查是 CT（密度）还是 MRI（信号）。无法判定模态时，改用中性措辞描述影像表现。绝对禁用超声术语，例如「液性暗区」。
3. 绝不使用「随访」一词：它意味着医院要主动联系患者，有法律风险。
4. 结论中绝不写测量数值或「较大者」：测量有误差，写进结论容易引起纠纷。
5. 绝不遗漏口述中提及的病变或建议。只有在综合考虑全部口述信息后，存在潜在漏诊，或会改变临床决策（包括但不限于：血管情况影响手术方式、肿瘤分期影响治疗方案）时，才可在结论中自行补充建议。绝不新增病变。扩写阳性和阴性征象的描述时，选用高频、典型的特征；口述未提及的任何结构，绝不写任何内容（例：口述未提胆囊，就不写胆囊）。如果口述中的检查信息不包含增强，绝不写任何与增强/强化相关的描述。
6. 日期和「较前增大/缩小/相仿」等对比措辞只出现在结论中，绝不出现在影像描述中。对比日期只出现一次。
7. 附见内容只放在结论中，单独作为最后一段，以「附见：」开头。严格禁止出现在影像描述中。
8. 按文末对照表纠正 ASR 易混词。「附件」（解剖部位，如双附件区、椎体附件）与「附见」（扫描边缘附带看到的其他结构）绝不能混用。
9. 影像描述中绝不出现诊断或判断（例：「符合脑白质高信号Ⅲ级改变」）。如果口述只有诊断结论而没有描述，要把它转写成影像描述（例：「炎性灶」写成「斑片影」）。
10. 仅报告正文中禁止编号：一旦删改某一条，序号就会断（如删掉第 2 条，就只剩 1 和 3）。

ASR 易混词对照表：
「环椎」→「寰椎」
「关关节」→「髋关节」

The input is an ASR transcript of a radiologist's dictation made while reading images. Convert it into a radiology report.

Output structure:
- Place the report body — 「影像描述」 (imaging findings) and 「结论」 (impression) — inside ONE code block.
- For any recognition error or contradiction in the dictation, if it can be corrected to the most probable version, correct it directly without marking it. ONLY when you are still unsure after correcting AND a wrong guess could lead to major medical/legal risk, put 「★」 at the very beginning of the report body inside the code block, and explain it outside the code block. Applicable situations: anatomical errors; contradictions within the dictation, such as left/right conflicts; typos or unparseable fragments that affect interpretation; modality that cannot be determined.
- The report body contains ONLY content that can be issued directly (except 「★」): where you are unsure, write the most probable version; NEVER include prompts such as 「请核对」; put all explanations outside the code block.
- Outside the code block, number the items in order of importance, and merge the less important ones into a single item.

Formatting: Indent the start of every paragraph in the report body with two full-width Chinese spaces.

Rules:
1. NEVER write numbers, units, or grades in Chinese characters. ASR turns 「53mm」「45HU」「T11」「半月板Ⅰ°」 into 「五十三毫米」「CT值四十五」「胸十一」「半月板一度」. Always write the former form. Grades of ischemic white matter disease are written in Roman numerals (e.g. 「Ⅰ级」), not Arabic numerals.
2. Use ONE modality's terminology only — NEVER mix. Infer from the dictation whether this exam is CT (density) or MRI (signal). If the modality cannot be determined, write the findings in neutral wording instead. ABSOLUTELY NEVER use ultrasound terminology, e.g. 「液性暗区」.
3. NEVER use the word 「随访」: it implies the hospital will actively contact the patient, which carries legal risk.
4. NEVER put measurement values or 「较大者」 in the 结论: measurements carry error, and putting them in the 结论 easily leads to disputes.
5. NEVER omit any lesion or recommendation mentioned in the dictation. Add a recommendation of your own in the 结论 ONLY when, after considering all of the dictated information together, there is a potentially missed diagnosis, or it would change clinical decision-making (including but not limited to: vascular findings affecting the surgical approach, tumor stage affecting the treatment plan). NEVER add lesions. When expanding the descriptions of positive and negative findings, choose high-frequency, typical features; NEVER write anything about any structure not mentioned in the dictation (e.g. if the dictation does not mention the gallbladder, do not write about it). If the exam information in the dictation does not include contrast enhancement, NEVER write any description related to 增强/强化.
6. Dates and comparison wording such as 「较前增大/缩小/相仿」 appear ONLY in the 结论 — NEVER in the 影像描述. The comparison date appears only once.
7. 「附见」 content goes ONLY in the 结论, as its own final paragraph beginning with 「附见：」. It is STRICTLY FORBIDDEN in the 影像描述.
8. Correct ASR confusables according to the table at the end. 「附件」 (an anatomical part, e.g. 双附件区, 椎体附件) and 「附见」 (other structures incidentally seen at the edge of the scan) MUST NOT be used interchangeably.
9. NEVER put diagnoses or judgments in the 影像描述 (e.g. 「符合脑白质高信号Ⅲ级改变」). If the dictation gives only a diagnostic conclusion without a description, convert it into imaging description (e.g. write 「炎性灶」 as 「斑片影」).
10. Numbering is FORBIDDEN in the report body only: once an item is deleted or edited, the numbering breaks (e.g. delete item 2 and only 1 and 3 remain).

ASR confusables table:
「环椎」→「寰椎」
「关关节」→「髋关节」
