# Getting Started with GitHub and hosting your work using GitHub Actions

Ok, so we have a bunch of nice looking graphs that we would like to tell everyone about. We could just show these to them on our own computer, but often what people do in research is to make them available online for everyone to see. This is where GitHub comes in.

> Why is GitHub? Why do people use it?

## Creating a GitHub Account

To create a GitHub account, follow these steps:

1.  Open your web browser and go to the GitHub website: <https://github.com>
2.  Click on the "Sign up" button in the top-right corner of the page.
3.  Enter your email address, create a password, and choose a unique username for your GitHub account.
4.  Click on the "Create account" button.
5.  Choose the Free plan and click on the "Continue" button.
6.  Follow the on-screen instructions to complete the account setup process, such as verifying your email address and setting up two-factor authentication (optional but recommended).

Congratulations! You now have a GitHub account! The next step is to create a repository (folder) where we can put our stuff in.

## Creating a repository

Click on the "+" icon in the top-right corner of the page and select "New repository" from the dropdown menu.

On the "Create a new repository" page, enter the following information:

-   **Repository name**: Enter `in2science_placement` as the name.
-   **Description** (optional): Add a brief description if you want.
-   **Visibility**: Select 'Public'

Choose the repository initialization options:

-   **Add a README file**: Check this box to create a default README file for your repository. The README file is a place to provide information about your project and its purpose (although we will be changing this in the next stage).

Click on the "Create repository" button to create your new repository. After the repository is created, you will be redirected to the repository page.

## Creating a README on GitHub

Ok, so at this stage we should have a repository called `in2science_placement` with a blank `README.md` file. Now we need to add our graphs and code to the README.

A README file is a special file in a GitHub repository that serves as an introduction/overview of the repository. It is typically the first file that visitors see when they visit a repository on GitHub. The purpose of a README file is to provide essential information about the project.

The cool thing about README's is that they are written in Markdown, a language where you can add code and images, which is what we are going to do for our graphs.

### Customising your README

To edit your `README`, click on the pencil icon at the `README's` top right, which will allow you to enter the editor.

You want for people to know the following:

1)  The background for your repository
2)  A description of the analysis that you did
3)  The code which you used to run the analysis
4)  The graph showing the output

`README` files can support text of many different types, but require specific syntax. Here are some of the most commonly used:

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

Normal text

**Bold text**

*Italic text*

***Bold and italic text***

~~Strikethrough text~~

> Blockquote

- Unordered list item 1
- Unordered list item 2
  - Nested list item

1. Ordered list item 1
2. Ordered list item 2
   1. Nested ordered list item

`Inline code`

---

[Link text](https://www.example.com)

Feel free to use these when structuring your own `README`!

We also need to add our code and plots from earlier. You can choose two/three graphs from earlier to add, each of which will supplemented by a brief description and the code used to create it.

> How are code and images formatted on Markdown?

Code you can just copy directly from your original code in R, but need to be contained within quotes. For example: 

```r
ggplot(combined_data, aes(x = age, y = RT, color = ID)) +
  geom_point(alpha = 0.5) +
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1),
               geom = "errorbar", width = 0.4, color = "black") +
  stat_summary(fun = "mean", geom = "point", shape = 21,
               fill = "white", size = 3) +
  geom_smooth(method = "lm", se = TRUE, color = "black",
              fill = "gray", alpha = 0.2) +
  labs(x = "Age", y = "Reaction Time", color = "ID") +
  theme_classic() +
  guides(color = FALSE)
```

Images on the other hand are a bit trickier, because you need to provide a weblink to the path of the image on your GitHub account. You can do something like this:

```html
<p align="center">
  <img src="https://github.com/sohaamir/repository_name/blob/main/img/image_name.png" alt="Image Description" width="x" height="y">
</p>
```

::: {align="center"}
<img src="https://github.com/sohaamir/placement_materials/blob/main/img/stop.png" width="50%"/>
:::

<br>

## Publishing your README using GitHub Actions

So once you have your `README` with the code and graphs added, the final thing is to publish it using GitHub Actions. For our purposes, GitHub Actions is a way of turning our `README` into a webpage that visitors can see.

We need to firstly enable GitHub Actions before we can run it. To enable GitHub Actions do the following:

-   Go to your repository settings.
-   Click on the "Actions" tab in the left sidebar.
-   Under "Actions permissions," select "Allow all actions".

::: {align="center"}
<img src="https://github.com/sohaamir/placement_materials/blob/main/img/github_actions.png" width="80%"/>
:::

<br>

-   Click on the "Save" button to save the settings.

Now we can create what's called a 'workflow'. Essentially, whenever we change or edit the `README` this workflow will be ran. Our workflow is to publish it as a webpage.

To do this do the following:

-   In your GitHub repository, click on the "Actions" tab.
-   On the "Get Started With GitHub Actions" page, you have the option to start with a pre-made template or set up a workflow yourself. Since you want to publish your README to HTML, you can click on the "Set up a workflow yourself" button.

::: {align="center"}
<img src="https://github.com/sohaamir/placement_materials/blob/main/img/github_workflow.png" width="80%"/>
:::

<br>

-   You'll be taken to a page where you can edit the workflow file. Paste the following code:

``` yaml
name: Publish README to HTML

on:
  push:
    branches:
      - main

jobs:
  publish:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
      
    - name: Convert README to HTML
      uses: actions/setup-node@v2
      with:
        node-version: '14'
        
    - run: |
        npm install -g marked
        marked README.md -o index.html
        
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./
```

This will publish our `README` as a webpage everytime it is updated.

Now commit the changes and add the following text: 'created first README to html workflow'

After you've done that, go back to your `README` and make any change (you can just press space and backspace).

The GitHub Actions workflow should not automatically happen, because we made changes to our `README`. To see the workflow in action, go to the 'Actions' tab.

It shouldn't take long, but if ran successfully, you should see the following:

::: {align="center"}
<img src="https://github.com/sohaamir/placement_materials/blob/main/img/github_workflow_success.png" width="80%"/>
:::

<br>

If you just click on that link, it should open your `README` as a webpage, now hosted online!

::: {align="center"}
<img src="https://github.com/sohaamir/placement_materials/blob/main/img/github_webpage.png" width="80%"/>
:::

<br>

Well done, you just published your work online so now everyone can know what you've achieved during your placement!
