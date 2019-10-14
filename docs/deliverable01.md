
# Deliverable 1


## GitHub Project

You can create your project using GitHub Class, following
the link below (in fact you probably got here by doing just that)

* https://classroom.github.com/g/1lTGFv8J

## GitHub Issues

Enter in GitHub all tasks (you will need to break the deliverables
into smaller tasks) and who is responsible for each task, as show
in the image below.

<img width="1008" alt="Screen Shot 2019-09-18 at 8 59 33 AM" src="https://user-images.githubusercontent.com/48086/65150708-a7ada980-d9f2-11e9-831d-6929dfe0645f.png">

Each task will be assigned to someone

<img width="1021" alt="Screen Shot 2019-09-18 at 9 00 49 AM" src="https://user-images.githubusercontent.com/48086/65150859-f1968f80-d9f2-11e9-99c5-26d144c53201.png">

And you can use labels and milestones to better track your work.

<img width="344" alt="Screen Shot 2019-09-18 at 9 01 32 AM" src="https://user-images.githubusercontent.com/48086/65150905-05da8c80-d9f3-11e9-9f1e-764c1ecb989a.png">

## Feature Branch

After this point, all work should be done against a deliverable feature branch.
You are free to create additional branches, but all work for this deliverable
should be in `f/deliverable01` prior to the submission deadline.

The very first contributor can create the btranch using

```
git checkout -b f/deliverable01
git push -u origin HEAD
```

Other contributors will need to checkout that new branch

```
git fetch
git checkout f/deliverable01
```

In addition, you might want a script similar to the following
to easily tell you which branch you are on

This can be located within `~/.bash_profile` (or `~/.bash_aliases`) and is known
to work on a Mac OSX

```
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

PS1="$RED\$(date +%H:%M) \w$YELLOW \$(parse_git_branch)$GREEN\$ "
```

Your terminal then might look similar to

<img width="522" alt="Screen Shot 2019-09-18 at 9 07 50 AM" src="https://user-images.githubusercontent.com/48086/65152811-aed6b680-d9f6-11e9-8080-5aa4a7ced5d3.png">


## Deliverables

In this deliverable, you need to implement the user account management component. That is, the app needs to allow users to create user accounts.

To simplify the development, there will be a single admin account (username: admin, pwd: 5T5ptQ), but it should be possible to create as many walk-in clinic employee accounts and patients as desired.

Once the user logs in, they should see a second screen with the following message:

```
Welcome [firstname]!
You are logged in as [role].
```

Ex. If a patient named Neymar (he injured his back while diving) logs in, he/she should receive the following message:

```
Welcome Neymar!
You are logged-in as a patient.
```

No additional functionality needs to be implemented at this point.

You can use Firebase or SQLite as DB support.


## Submission

You can install [Hub](https://github.com/github/hub)
a command line tool to create pull requests
from your terminal directly into GitHub.

For deliverable one, create a Pull Request with
the following information

```
hub pull-request -o -b master -m "Deliverable 1"
```

Your PR description (and text file to submit to BrightSpace)
will look similar to the following:

```
Forward Inc.
Team Members
Andrew Forward, 1484511 
James Url | 1929204 
Ayana Nurse | 2128439

PR:
https://github.com/professor-forward/walkinclinic/pull/2

Last Commit:
https://github.com/professor-forward/walkinclinic/commit/564d6484cce8af2ae6c15891178b2b086a4cb9ff

Instructions

+ Additional instructions about this deliverable
```

You will upload this file to BrightSpace before the deadline.

## Marking Scheme

| Feature or Task | Weight (/100) |
| --- | --- |
| Github: Repository created in Github contains all members of the group, the professor and the TAs.  All tasks/issues are assigned. | 10 |
| Github: Each member of the group has made at least ONE commit to the repository. | 20 |
| UML Class diagram of your domain model (-2 for each missing class)<br>(-2 for each missing class)<br>(-2 for incorrect generalization)<br>(-0.5 for each incorrect multiplicity)<br>(-0.5 for each missing attribute) | 30 |
| APK submitted | 5 |
| Can create a walk in clinic employee account | 10 |
| Can create a patient account | 10 |
| Can see the `Welcome screen` after successful authentication.<br>Can see the user role<br>Can see the name or username associated to the account | 5 |
| Fields are validated in all screens(e.g. Firebase or SQLITE, or other similar technology)<br>(e.g. you can’t enter an invalid email, name, etc)<br>(-1 for each field in which the user input is not validated) | 10 |
| OPTIONAL - Group uses a DB<br>(e.g. Firebase or SQLITE, or other similar technology) | + 25 |
| Note: Passwords must be stored as hash values using SHA-256.<br>(lose marks if not implemented)<br>See [MessageDigest](https://developer.android.com/reference/java/security/MessageDigest) documentation | - 10 |

