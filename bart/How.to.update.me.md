# How to update this folder and readme.md file

## Reason

In order  to avoid a truck number of just 1, this document is my (Ed) attempt
to document my process of updating Bart's folder in this PBS Student Org
repository.

## Steps I follow

We need to get 3 things from 2 pages on Bart's web site.

1. The current .zip for the most recent show installment
  * Contains the challenge solution and supplement files for last installment's homework
2. The show title of the previous installment
  * Contained in the id attribute of the 2nd H1 tag or the previous show page's .html
3. The homework challenge text from the previous show page




The index of show notes are here: [PBS Home page](https://pbs.bartificer.net)

Using a web browser go there and when there search for:

The current show number
(Like Command plus F then 150)


Click on that link and when on the current show page, download the .zip for that
installment. (Do nothing yet with that .zip file)

Go back in your history and then search for the previous show installment. Click
on that  link. When there, look for the challenge text for the homework.
Copy that text and then update the 'readme.md' in this folder.

### Using Ed's handy-dandy get-show-id.sh script to create the folder name

You will need this folder name to update the 'readme.md' file.

### Before you begin:

You will need both 'curl' and 'htmlq' installed.

If you are on a Mac and have 'homebrew already installed:

```
$ brew install curl htmlq
```

#### curl

[https://github.com/curl/curl](https://github.com/curl/curl)

#### htmlq

You can check its web page for installation instructions:

[https://github.com/mgdm/htmlq](https://github.com/mgdm/htmlq)
Ed's script is kept in his folder and takes 1 argument: The show number
(of the previous installment)

E.g. Say we are on show 151 currently, then do this (Note we need show 150: 1 less than the current)

```
$ ../edhowlnd/lib/bart-automation/get-show-id.sh 150
pbs-150-of-x--bash-script-plumbing

$ # Need to create a folder of that name
$ mkdir $(../edhowlnd/lib/bart-automation/get-show-id.sh 150)
```


### Now unzip the folder from the current show. (E.g. pbs 151)

- cd to that unzipped folder name (of of the .zip without the .zip extension)

E.g.

```
$ unzip pbs151.zip
$ cd pbs151
```

Look in there for a filename like 

pbs-150-of-x--bash-script-plumbing/pbs150-challengeSolution.sh



Again, note the number is 150 although we are currently in folder pbs151/
and there maybe files in there named with the 151 handle. Ignore them.


## Copy the challenge-solution script file to the previously created folder.

E.g.
cp pbs150-challengeSolution.sh pbs-150-of-x--bash-script-plumbing/
```


Note: There may be additional files you need to copy from the unzipped folder
to make it work. Like data files or other text files. Copy those files
from the unzipped folder  into the folder you created above.


## Updating the 'readme.md' file



Create a new section with heading level 2 with the name of the folder you
previously created

Place the new heading immediately below this line:

##### Challenges are below this line




E.g. Say we are doing PBS150:

Add this:

##  pbs-150-of-x--bash-script-plumbing




Note that line matches the exact folder name you previously created but with
2 #'s just before it




### In your web browser, go to the previous installment's show page

E.g. Hit the back button or press: Command plus [

Then search for the show number of the previous installment.

E.g. Say we are currently on PBS151:

Press Command plus f then enter 150 and press Return

Skip most of the show notes and move to 
the 'challenge' heading. This might be the next Heading level 2 past the 

'Final thoughts' heading.

Copy and paste this text from the web page after this 'challenge' heading
into the 'readme.md' file directly after the '## pbs-1XX-.... heading you
previously creating



## Add in the link to the web page after the instructions

Back in your web browser, get the URL of the current page and copy it to the
clipboard. Then create a link Markdown entry in the 'readme.md' after 
theinstructions you just pasted.

E.g.

```
[PBS 148 Show Notes](https://pbs.bartificer.net/pbs148)
[PBS 150 Show notes](
```


Save the 'readme.md' file. get add both the 'readme.md' file and the directory you created.

E.g.

```
$ git add readme.md pbs-150-of-x--bash-script-plumbing/

```

## Final steps

I would actually test the script file that Bart made by going into that folder
and trying to run it. You may need the instructions you copied from the web page
into the 'readme.md' file.

If you are satisfied that all these steps have been done, then do the following

```
$ rm -rf pbs150.zip pbs150/
git add .
git commit
```

Add in a descriptive commit message saying that you updated Bart's folder with
the show number (1 less than the current show)





Then do a final git status

````
$ git status
```

Make sure there are now file or directory straglers about.

If there is nothing to commit because you just committed and there are no
untracked files you can get ready to perform a pull then push.


E.g.

```
$ git pull
$ git push
```

You may need to resolve merge conflicts between these 2 steps.

## Final thoughts

Remember that we get the actual solution script from this week's show page and
the downloaded .zip from there. But we place it in the previous numbered
folder in this folder., not in the same numbered folder of the current
episode. This also applies to the 'readme.md' text update.
And remember to remove both the .zip and the unzipped folder you downloaded
from the current episode web show note's page. do not git add them and commit.
Or Allison will be mad at you.

Future considerations

In the future, I wil probably create a new branch before starting this
adventure, then if it all goes smoothly, merge the branch back into mainbefore pushing it back up to GitHub.  


