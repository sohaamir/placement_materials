# Basic data analysis and plotting with ChatGPT and R

## What is the HAVEN project?

To help with the analyses that we will be working on, it makes sense to firstly understand what the study (HAVEN) is trying to understand (at least in part). To summarise, we are looking to understand how the brain changes over time, and how memory function is affected by these changes. We look to understand these changes by using a technique called functional magnetic resonance imaging (fMRI), which measures brain activity whilst older adults complete an episodic memory task.

You should firstly familiarise yourself with the HAVEN project, using the files available within the folder.

Here are some questions for you to answer:

1. What are we interested with understanding as part of the study?
2. What is episodic memory? Why are we looking at that specifically?
3. How does episodic memory change as we age? Why?
4. What are we making people do in the scanner? Why did we choose for them to do this specifically?
5. How can we measure how ‘well’ people do at the task?
6. What factors do you think will affect this?

And specifically relating to neuroimaging: 

1. What brain regions are we interested in and why?
2. What brain regions are involved with episodic memory?
3. How do these brain regions change over time? 
4. What are the methods that we are using?
5. What is MRI? What is fMRI? Why do we use both? What is the difference?
6. What is the importance of our research in the long term?

In your folder, you should have access to several files including data, information sheets and the workbook materials:

```
├── data
│   ├── correct_rt_data.csv
│   ├── participant_data.csv
│   └── rt_data.csv
├── information
│   ├── HAVEN.pptx
│   └── HAVEN_information_sheet.pdf
├── workbook
│   ├── answers.Rmd
│   └── workbook.md
```

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/haven_files.png" width="100%">
</div>
<br>

The HAVEN information sheet and PowerPoint provides information about the HAVEN study for you to work with, but a simple Google will help for understanding some of the topics. The [HAVEN webpage](https://research.reading.ac.uk/cinn/take-part/haven/) may also be useful. 

•	If you decide to have a read through these, just focus on the brain/psychology part (you don't need to worry about platelets!)

## Basic research/data analysis in R

Once you have understood what the HAVEN study is, you can work on some of the data! Within the folder I have attached a file containing mainly demographic data (e.g., Age, Sex, Height, Weight) but also whole-brain lesion data as well. This is contained within an R project which is a collection of files associated with some analysis/project that you are running.

I will help to set up the R project, but here are a few tasks to start with: 

-	Load in the `participant_data.csv` file
-	Assign the `participant_data.csv` file to a variable 
-	Print out the current directory in the R console
-	Run some basic commands such as `head` and `summary` on the data

Feel free to Google or ChatGPT how to do each of these!

Before you work on the data, ask yourself:

**What questions would you be interested in understanding? Why? What are the expected results that you would (hopefully) see?**

In doing so, we are creating some basic hypotheses before you do your analysis. This is a basic principle of science, as we use our existing knowledge to predict the results and experimentally validate them using our research. 

- Some of these may be straight forward (e.g., height and weight), but make some hypotheses about the lesion data. Do some research into the effects of lesions on memory function.

Once you have thought of some questions, think about how you are going to test them using the data? Maybe you can visualise them? And then perform some statistical tests? Which graphs work best for each of your questions? Which statistical tests are you going to use?

> If you're not sure about these then that's fine, this is just to put across that we think about our analyses before we do them, and often before we get any data at all.

Once you have an idea of what your research questions are, let me know and we can work on them together! 

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/stop.png" width="50%">
</div>
<br>

## Using ChatGPT to write code in R

You are most likely to have never programmed before. Up until a fairly recently, that would have made writing your own code to do analyses in R very difficult. But, in December 2022 OpenAI released ChatGPT. ChatGPT is incredibly useful for several things, but importantly it will write code based upon what you tell it using words. This is quite incredible. 

The thing with ChatGPT is that the more specific you are with what you give it, the better results it will churn out. For example, let’s say you loaded in the `participant_data.csv` file, assigned it to the `participant_data` variable, and wanted to plot height vs age. This is the ‘prompt’ that I would give ChatGPT:

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/chatgpt_prompt.png" width="70%">
</div>
<br>

This is a simple example, but you can use this same principle to create any graph in R.

Now take a look at the questions below. Work your way through each of these, and add your own questions if you would like!

I will be available to help, but if you want to see the ‘answers’ to these questions, you can open `data_answers.html` which is a file containing the code to run each of these. 

## Bonus material: Reaction times and accuracy

If we get this far in the tutorial, then I will go through some additional data gathered during the task that people completed whilst in the scanner. Essentially, we had people watch a video (a 30-minute episode of a sitcom) at about 8am, and then at about 10am they were shown in the MRI scanner two scenes from the episode, to which they had to select which scene came earlier in the video. 

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/haven_task.png" width="70%">
</div>
<br>

You will already understand what this task is trying to measure (episodic memory) and whilst we are not expecting differences in accuracy within the group, it could be something of interest. 

> Why do you think we not expecting significant differences with accuracy across the group?

To analyse this data, you can load the `rt_data.csv` file into R. This gives information regarding the percentage accuracy of participants, as well as the time taken (on average). 

Again, some example questions are below, and the template answers to these questions within the `answers.html` file.

### The final test

We can make significantly more complicated graphs in R. So far we are just scratching the surface! As a final example, try to re-create the graph below:

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/final_graph.png" width="100%">
</div>
<br>

It may seem extremely complicated, but it really isn't. Try to break down the graph into individual components:

- What is being measured each axis?
- How is the data grouped? 
- What additional stuff can we see?


## Data Analysis Workbook

Here is a workbook for you to work your way through. Struggling is part of programming, feel free to ask others for help. If you really are stuck, you can either ask me, or take a look at `answers.html` which has all of the solutions.

### Setting things up

1) Set your working directory to be the correct folder
2) Load in the participant data and assign it to a variable (hint: it's a csv file)
3) Run `head` and `summary` on the data

### Basic data plotting

> For each of these, think about which type of plot will work best, before actually writing the code.

1) Plot age against total lesion volume
2) Plot total lesion volume for males and females 
3) Plot height and weight for males and females on the same graph (hint: group by ___)
4) How is BMI spread across the group? (hint: a specific plot for data density may be useful here)
5) How is age spread across the group?
6) How is the spread of BMI and age different?

### Basic significance testing 

**t-test**
1) How many males and females are in the group?
2) What is the mean height and weight for males and females?
3) Are males and females signifciantly different in height or weight? (hint: run a t-test)

**Correlations**
1) Plot the correlation between age and total lesion volume
2) Is this significant or not?
3) Remove subject 21 and 30, and replot 4)
4) Is this now significant or not?

**Separating by sex**
1) Plot on the same graph the correlation between age and total lesion volume for males and females separately
2) What do you see?

### Behavioural data

I'm purposely being more vague with the instructions here...

1) Load the reaction time data and assign it to a variable
2) Does correct_rt and correct_percent correlate with age?
3) What about when you separate them by sex?
4) Does lesion volume or lesion number correlate with correct_rt or correct_percent?
5) Remove the outliers (which do you think are the outliers) and re-plot 4)
6) Is it signifcant or insignificant now?

### The final test

1) Recreate the graph provided above.



