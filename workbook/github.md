# Getting Started with GitHub and hosting your work using GitHub Actions

Ok, so we have a bunch of nice looking graphs, that we would like to tell everyone about. We could just show them on our own computer, 
but often what people do is to make them available online. This is where GitHub comes in.

> Find out what GitHub is and why people use it

## Creating a GitHub Account

To create a GitHub account, follow these steps:

1. Open your web browser and go to the GitHub website: https://github.com
2. Click on the "Sign up" button in the top-right corner of the page.
3. Enter your email address, create a password, and choose a unique username for your GitHub account.
4. Click on the "Create account" button.
5. Choose the Free plan and click on the "Continue" button.
6. Follow the on-screen instructions to complete the account setup process, such as verifying your email address and setting up two-factor authentication (optional but recommended).

Congratulations! You now have a GitHub account! The next step is to create a repository (folder) where we can put our stuff in.

## Creating a repository

Click on the "+" icon in the top-right corner of the page and select "New repository" from the dropdown menu.

On the "Create a new repository" page, enter the following information:

- **Repository name**: Enter `in2science_placement` as the name.
- **Description** (optional): Add a brief description if you want.
- **Visibility**: Select 'Public'

Choose the repository initialization options:

- **Add a README file**: Check this box to create a default README file for your repository. The README file is a place to provide information about your project and its purpose (although we will be changing this in the next stage).

Click on the "Create repository" button to create your new repository. After the repository is created, you will be redirected to the repository page. 

Ok, so at this stage we should have a repository called `in2science_placement` with a blank `README.md` file. Now we need to add our graphs and code to the README.

## What is a README File?

A README file is a special file in a GitHub repository that serves as an introduction/overview of the repository. It is typically the first file that visitors see when they visit a repository on GitHub. The purpose of a README file is to provide essential information about the project.

The cool thing about README's is that they are written in Markdown, a language where you can add code and images, which is what we are going to add. 

### Editing your README

To edit your `README`, click on the pencil icon at the `README's` top right, which will allow you to enter the editor.

You want for people to know the following:

1) The background for your repository
2) A description of the analysis that you did
3) The code which you used to run the analysis
4) The graph showing the output

For steps 1-4, you can choose two/three graphs to add, each of which will have a brief description, code and the plot itself.

 Again, you will need to either Google or ChatGPT how to insert code/images. 
 
 Code you can just copy directly, but need to be contained within quotes. For example:
 
 ```
 ggplot(combined_data, aes(x = age, y = RT, color = ID)) +
  geom_point(alpha = 0.5) +
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1), geom = "errorbar", width = 0.4, color = "black") +
  stat_summary(fun = "mean", geom = "point", shape = 21, fill = "white", size = 3) +
  geom_smooth(method = "lm", se = TRUE, color = "black", fill = "gray", alpha = 0.2) +
  labs(x = "Age", y = "Reaction Time", color = "ID") +
  theme_classic() +
  guides(color = FALSE)
 ```
 
Images on the other hand will be a bit trickier, because you need to provide a weblink to the path of the image online. I would recommend that you let me know when you get to this stage so I can set this up for you on my own account.

<div align="center">
  <img src="https://github.com/sohaamir/placement_materials/blob/main/img/stop.png" width="100%">
</div>
<br>
 
### Publishing your README using GitHub Actions

So once you have your `README` with the code and graphs added, the final thing is to publish it using GitHub Actions. For our purposes, GitHub Actions is a way of turning our `README` into a webpage that visitors can see. 

To set-up your GitHub Actions, do the following:



