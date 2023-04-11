# pbs-challenges
This is a place for learners to share their code with other learners.

## Rules:

1. Use your folder to keep your own code. Don't modify anyone else's files in their own folders
2. Please try to use the naming convention of your own folders as leading with `pbsxxx-`. e.g. `pbs146-shell-loops`. This will help others to find your code for a particular challenge.
3. Play nice.

## How to Get Back to a Previous Commit without Breaking Other People's Commits

The design of the pbs-challenges repo allows us all to see each other's work in progress, but it introduces a challenge. If you make a commit to your files, then I make a commit to my files,  and then you check out your previous commit, my commit could be affected.  

Here's the process to get back to your previous commit without borking anyone else's work.

1. Get rid of your local changes and restore the specific file(s) you will be changing back to your previous commit:
`git restore filename`
You should see a clean working tree with `git status`

2. Create and checkout a new branch:
`git checkout -b branchname`

3. Revert to the commit using the hash of the commit:
`git revert hash`
This will automatically launch vi with a commit message created to document this revert. You can edit the commit message, or simply hit escape, followed by `:wq!` to write, quite and save it as is.

4. Check out the main branch:
`git checkout main`

5. Merge the branch you created into main:
`git merge branchname`

6. Clean things up by deleting the branch you created. You can see all branches with:
`git branch --all`
and then delete the branch with:
`git branch -d branchname`

7. Applaud yourself for being a polite NosillaCastaway who plays nice.