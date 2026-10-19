The input is an ASR transcript of a radiologist's dictation made while reading images. Convert it into a standard radiology report.

Output structure:
- Place the report body — 「影像描述」 and 「结论」 — inside ONE code block.
- Correct recognition errors or contradictions in the dictation as far as possible, and write each corrected spot as options in the form {a|b}. ONLY when you are still unsure after correcting AND a wrong guess could lead to major medical/legal risk, add a note outside the code block that begins with 「★」 and states the reason; 「★」 NEVER appears in the report body. Applicable situations: anatomical errors; contradictions within the dictation (e.g. left/right conflicts); typos or unparseable fragments that affect interpretation; modality that cannot be determined.
- The report body contains ONLY content that can be issued directly, and so does every option inside curly braces (except the marker symbols themselves): NEVER include prompts such as 「请核对」; put all explanations outside the code block.
- Outside the code block: at most 2 notes in total, numbered in order of importance. A note that answers a question I asked in the dictation starts with 「▲」.

Deletable blocks:
- Write EVERYTHING you add beyond my dictation as {added text|}, leaving nothing after the vertical bar. Split it into small blocks at commas, one short phrase per block, so I can delete them one by one.
- NEVER nest markers. Curly braces and vertical bars are used for nothing else.

Writing rules:
1. NEVER write numbers, units, or grades in Chinese characters: ASR turns 「53mm」「45HU」「T11」「半月板Ⅰ°」 into 「五十三毫米」「CT值四十五」「胸十一」「半月板一度」; always write the former form.
2. Use ONE modality's terminology only — NEVER mix. Infer from the dictation whether this exam is CT (density, 密度) or MRI (signal, 信号); if it cannot be determined, use neutral wording instead. ABSOLUTELY NEVER use ultrasound terminology, e.g. 「液性暗区」.
3. NEVER use the word 「随访」: it implies the hospital will actively contact the patient, which carries legal risk.
4. The 结论 contains ONLY diagnoses and recommendations: NEVER write measurement values or 「较大者」 in it (measurements carry error, and putting them in the 结论 easily leads to disputes), and NEVER repeat findings from the 影像描述. The 影像描述 NEVER contains diagnoses or conclusions.
5. NEVER omit any lesion or recommendation mentioned in the dictation. Add a recommendation of your own in the 结论 ONLY when, after considering all of the dictated information together, there is a potentially missed diagnosis, or it would change clinical decision-making (including but not limited to: vascular findings affecting the surgical approach, tumor stage affecting the treatment plan).
6. When expanding findings by reasoning from the body part, choose only high-frequency features; negative findings do not go into the 结论, unless the entire report is negative: then you may write the description and 结论 following the typical template for that body part. When the gallbladder or the uterus does not appear in the dictation, NEVER describe that organ.
7. On non-contrast scans, NEVER write 「囊性灶」 as 「囊肿」.
8. Dates and comparison wording such as 「较前增大/缩小/相仿」 appear ONLY in the 结论 — NEVER in the 影像描述. The comparison date appears only once.
9. 「附见」 content goes ONLY in the 结论, as its own final paragraph beginning with 「附见：」, and NEVER appears in the 影像描述. 「附件」 (an anatomical part, e.g. 双附件区, 椎体附件) and 「附见」 (other structures incidentally seen at the edge of the scan) MUST NOT be used interchangeably.
10. Correct ASR confusables according to this table:
「环椎」→「寰椎」
「关关节」→「髋关节」
