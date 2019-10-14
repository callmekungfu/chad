# Android Project: Walk in Clinics Services App

The application addresses the need for people to know waiting times at nearby walk-in clinics without having to leave their home. It also allows users to know the services offered by nearby walk-in clinics and allow them to check-in/book appointments at the clinic of their choice.


## Instructions

1. Project will be done in teams of 5 +/- 1 person.
2. Only one team member needs to submit the deliverables via Brightspace, but make sure
all team members are identified (name and student number) on your cover page or
README.md file.
3. The team must present only one version of the application. For instance, one student
having one screen with the search functionality and other one having another different screen (running on a different phone) with the clinic’s employee functionality, **WILL NOT** be accepted. The team must produce a single application with all the required functionality.

The purpose of this project is to expand on the theoretical work, allowing students to gain practical experience implementing the concepts learned in class. This project is also designed to allow students to learn how to work with their colleagues and develop mobile applications. Learning outcomes range from increased understanding of concepts relating to software engineering, to overall knowledge of programming for android, management and team-relation skills.

The main outcome of the project is the implementation of a walk in clinics services application for android devices. Students are to implement all components of the project, from their design, specification, UML and additional documentation, graphical assets and source code. Students are encouraged to use the available toolset in android studio but should refrain from
copying whole blocks of code from the internet to implement features. Should a group want to use a non-standard tool/API they should request permission before doing so.

---

The app will be conceived with three different types of users in mind. The administrator, the walk-in clinics employees, and the patients. The administrator manages all the possible services that can be offered to patients by walk-in clinics. The walk-in clinic employee creates a profile for the clinic and selects the services offered by the walk-in clinic and the working hours. The patients can search for a walk-in clinic by address/type of service provided or by working hours.

The features that should be available to each type of user are given below. Note that those are the minimum required features, and you are free to add more features you think might enrich your application.

### The administrator can:
1. Create services (at least 5) to be offered by walk-in clinics using the application.
2. Delete accounts of walk in clinics and users

### The walk in clinic employee can:
1. Create an account for the walk in clinic
2. Select services provided and the rate for each service
3. Enter the working hours of the walk in clinic

### The patient can:
1. Create an account
2. Search for a walk in clinic by address/type of service provided/working hours
3. Check in/book an appointment
4. Rate his/her experience at the walk in clinic

### Your application should:
1. Show the expected waiting times for walk in clinics based on the number of patients waiting to be seen (assume a fixed time of 15 minutes per patient)
2. Show the rating that each walk in clinic has
3. Show the admin account all registered users to allow him/her to delete user accounts

**Note**: This course does not focus on interface design; hence, we do not focus on usability aspects. However, students are welcome to “beautify” their projects, should they be comfortable with user interface design. Consider the Android Design Guidelines when designing
your application. This topic will be covered in a tutorial session and detailed information is available at: https://developer.android.com/design/index.html

---

## DELIVERABLES

The project is divided into 4 incremental deliverables (and 1 demo).

Each deliverable will include the following:

* A feature branch with all content for the deliverable
* A Pull-Request (PR) of that branch back into the main branch
* PR approved by all team members and merged back into the main branch
* A README.md outlining the team members, and a summary of the deliverable

Students are required to submit a text file containing links to the
above by the posted deadline online using Brightspace.

For example

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

A break down of the marking scheme for the project is below.
Note that you will be responsible for giving a demo to your
TAs during the last week of labs / tutorials.

Click on the deliverable name for more details.

| # | Deliverable | Weight | Due Date |
| --- | --- | --- | --- |
| 1 | [Github repository and user accounts](/docs/deliverable01.md) | 3% | Oct 20 |
| 2 | Admin functionality | 3% | Nov 10 |
| 3 | Walk-in employee user functionality | 3% | Nov 20 |
| 4 | Patient and application functionality | 9% | Dec 04 |
| 5 | Demo (during labs / tutorials) | 2% | Last week |

The project is to be carried out throughout the session and students are
strongly encouraged to maintain a log of their project activities,
as task allocation and project flow are a component of the final
document provided alongside the android application.
We suggest students keep track of duty assignment, with complexity
of allocated tasks and completion dates. **You can track and assign tasks
with GitHub**.

Your application must be written in Java and built using the Android Studio 3.1. You should compile your project against the earliest possible SDK version allowed by the API methods you are using (API 10, level 29). By the end of the semester, you must implement and submit a working application based on the specifications. Firebase or SQLite can be used for storing and retrieving the application data.


## ACADEMIC HONESTY

All work that you do towards the fulfillment of this course's expectations
must be your own unless collaboration is explicitly allowed (e.g., by some
problem set or the final project). Viewing or copying another individual's
work (even if left by a printer or stored in a public directory) or lifting
material from a book, magazine, website, or other source-even in part- and
presenting it as your own constitutes academic dishonesty, as does showing
or giving your work, even in part, to another student.

