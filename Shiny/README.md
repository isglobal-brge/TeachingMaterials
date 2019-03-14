# Creating Shiny Apps for biostatisticians and bioinformaticians

Repository with the material corresponding to the course __Creating Shiny Apps for biostatisticians and bioinformaticians__ given at 
[ISGlobal](http://www.isglobal.org) (former CREAL). Each folder contains slides, R code, data and exercises of each topic.

The course will be given in Spanish. In this [link]() you can also find the course's description including how to be registered in Spanish. 

## License
 
Unless otherwise stated, all material is licensed under a
[Creative Commons Attribution-ShareAlike 3.0 License](http://creativecommons.org/licenses/by-sa/3.0/).
This means you are free to copy, distribute and transmit the work,
adapt it to your needs as long as you cite its origin and, if you do
redistribute it, do so under the same license.

# Introduction and objectives

[Shiny](http://shiny.rstudio.com) is an [R](http://www.r-project.org/) package developed by [RStudio](http://www.rstudio.com/) which allows to create dynamic web-based applications without HTML, Javascript, PHP or other web specific languages. Thanks to Shiny, it is possible to rapidly and easily build and customize graphical interfaces with few lines of R code uniquely. In this way, it is feasible to share functions written in R with other users not familiar with it and who want to use them interactively, that is, by _clicking_ instead of having to write the
commands. It is really useful, for instance, to groups that do not have programmers, bioinformatics and/or biostatistics.


# Addressed to 
Graduate or PhD students, professors or investigators who use R in their daily work, with low or null knowledge of web specific languages such as HTML, PHP or Javascript, and who want learn how to create web-based graphical interfaces.

# Methodology
The course will be eminently practical. Its contents will be introduced by examples. At the end of each block (every 1 or 2 hours) an exercise that the students must solve in class will be proposed. Throughout the course, the examples will be discussed modifying some of them and
giving possible alternatives so that the concepts are better assimilated. Students will have the slides of the course as well as the code used both in the presentation and to solve the exercises. 

# Schedule
The course will take place in the Campus Mar del Instituto de Salud Global de Barcelona, [ISGlobal](www.isglobal.org) locateed at the Biomedical Research Park of Barcelona (PRBB) on May 21 st
and 22nd (Room: Ramon y Cajal, ground floor). 

The number of places for the course is limited to 20 and the places will be awarded STRICTLY in order of arrival of pre-registration, sending an email to gemma.punyet@isglobal.org specifying your name and institution.

The schedule of the course is the following:

- 21st: from 10h to 18 h.
- 22nd: from 9h to 18 h.

# Outline

**Day 1:**

- Part I (1h) – Introduction to Shiny and first examples (+ exercises).
- Part II (2h and 30min.) – Layout of the form elements: panels, buttons, dropdown lists, … (+ exercises)
- Part III (3h) – How Shiny works (+ exercises).

**Day 2:**

- Part IV (2h and 30min) – How to improve the appearance and functionality of the application.
- Part V (2h) – Advances issues.
- Exercise (2h) – Creating a real application.

The examples introduced throughout the course will include among other topics:

> *	Creating dynamic tables and plots.
> *	Analyzing selected variables from a dataset uploaded by the user.
> *	Building forms to add new registers in a query data base.
> *	Making apps only visible after entering a password.


# Material and requirements
Students must bring their own laptops. The classroom will have WiFi access to the Internet and students will have access to all course material including the packages, the R code and the necessary data to follow the classes and perform the exercises.

It is recommended to have the shiny package (available on CRAN) installed before starting the course. To check the correct functioning, when executing the following code, the application shown in the figure below should be launched.
```
library(shiny)
runExample("01_hello")
```

![](figures/shiny.png)

The course will use Rstudio as the main tool. All students must have installed the latest version of R and Rstudio one week before the course. Also, Chrome is recommended as the internet explorer to be used.
One week before the course begins, instructions will be sent so that all students have the same configuration and can follow classes efficiently.
To download RStudio, go to https://www.rstudio.com/products/rstudio/download/, and to
download R use https://cloud.r-project.org/.



# Organization
The course is organized by the Bioinformatics Research Group in Epidemiology [BRGE](http://brge.isglobal.org) lead by Juan R Gonzalez who organized serveral R/Bioconductor courses includin 16 editions of a course on genetic association analyses or 4 editions teaching how to create R packages. 

# Lecturer
Isaac Subirana is an Adjunct Professor at the UB working full-time as a Research Technician in the field of Cardiovascular Epidemiology in the REGICOR group at the PRBB.

He is the creator and maintainer of the R package compareGroups (www.comparegroups.eu) for which an application designed from the Shiny tools was implemented.


# Course cost and payment
The cost of the course is 290€ (10% discount to the first two BIB members to be pre-registered) which includes a small lunch that will take place in the middle of the morning as well as all the material of the course in electronic support (functions, packages and exercises solved) the slides and bibliographic material presented in the classes. 

The number of students will be of a maximum of 20 and the requests will be attended by strict order of registration. Payments must be made by bank transfer, to the account: 

CAIXABANK, S.A number ES96 2100 0555 3102 0201 5342. 

Once the deposit is made, the student will have to send the proof of the transfer to gemma.punyet@isglobal.org, along with the registration form with the participant that can be found [here](https://docs.google.com/forms/d/e/1FAIpQLSeUkYFlXuEKEAqR5S8p-3ilRlus2pQaKRt6xVcI_oYfV-Nl_A/viewform). 



# Access to ISGlobal - Campus Mar (PRBB)
The  Instituto de Salud Global Barcelona (ISGlobal) is located at PRBB:

 ![PRBB localization](figures/prbb_loc.png)


Se puede llegar a trav?s de varias v?as. Si necesit?is m?s informaci?n pod?is consultar la web de Transportes Metropolitanos de Barcelona ( www.tmb.net ).

Paradas de Metro cercanas al centro: L?nea 4 (amarilla) Barceloneta y Ciutadella.




