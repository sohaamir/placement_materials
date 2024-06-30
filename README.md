## Work Experience Placement Course - Basic Data Analysis and Plotting Using the HAVEN Dataset 🫀 🧠

<div align="center">
  <img src="https://raw.githubusercontent.com/sohaamir/placement_materials/main/img/readme.png" width="70%">
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/sohaamir/placement_materials/main/img/readme_no_bg.png" width="70%">
</div>


This is a repository detailing a work experience placement course where students will work with the [HAVEN](https://research.reading.ac.uk/cinn/research-studies/haven/) dataset acquired by the University of Reading. 

As part of the placement, students will:

- Gain a basic understanding of neuroimaging (MRI, fMRI) and its uses for scientific research
- Acquire practical experience in data analysis and plotting using R and ChatGPT
- Generate their own hypotheses and these these hypotheses using simple statistic tests (t-test, correlations)
- Upload their findings onto GitHub and publish as a webpage using GitHub Actions

Subsequently, the following are required:

- R/Rstudio (but also available online)
- ChatGPT account (free)
- GitHub account (also free)

The repository itself contains the following structure:

```
├── data
│   ├── correct_rt_data.csv
│   ├── participant_data.csv
│   └── rt_data.csv
├── information
│   ├── HAVEN.pptx
│   └── HAVEN_information_sheet.pdf
└── workbook
    ├── answers.Rmd
    ├── answers.html
    ├── github.md
    └── workbook.md
```
With the following folders:

- `data` contains data required for the analyses:
    - `participant_data.csv`, basic demographic data for 52 participants including age, sex, height, weight, BMI and education, as well as lesion volume and lesion number
    - `rt_data.csv` - participant data from the memory task performed by participants within the scanner, including the average reaction time for correct and incorrect responses, as well as participant accuracy.
    - `correct_rt_data.csv` is only required for the final example, and includes individual trial responses for each participant as well as their age.
- `information` contains a presentation and `pdf` detailing the HAVEN study.
- `workbook` covers how the students should progress through the placement:
    - `workbook.md` is the first workbook the student should complete, which covers the theoretical background including the HAVEN study, MRI/fMRI and episodic memory, as well as the practical data analysis and plotting.
    - `answers.md/html` are completed examples for the questions assigned to the student in `workbook` in both `markdown` and `html`.
    - `github.md` is to be completed after `workbook` and provides a guide to creating a GitHub account, adding a `README.md` detailing some of the analyses, and publishing this using GitHub Actions.

If you have any questions or issues, please open a thread or email me at axs2210@student.bham.ac.uk

Copyright (c) 2024 Aamir Sohail
