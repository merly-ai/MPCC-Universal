# MPCC-Universal
Thank you for visiting the Merly Mentor GitHub repository! We are happy you are here! If you enjoy using Merly Mentor and find it useful, we would greatly appreciate your feedback. 

Please email us with any questions, comments, issues, or anything related to Mentor to support@merly.ai or debugging@merly.ai. We would love to hear from you!

Mentor currently works with C, C++, C#, Fortran, Go, Java, JavaScript, PHP, Python, Rust, TypeScript, and VHDL. We plan to continue to add support for other programming languages in the future.

![merlydog_favicon](https://user-images.githubusercontent.com/92695077/163842195-66aabaa5-9db3-4499-8593-ae40fbef6e97.png)


## What is Merly Mentor?
At the highest level, Merly Mentor can be thought of a code-based reasoning system. More specifically, Merly Mentor (also
known as Mentor) is a self-supervised system, which utilizes federated learning and an iterative multi-tiered code abstraction
model to help reason about the semantics of code. An overview of Mentor’s system design is shown in Figure 1. Its distributed
learning framework enables it to learn from hundreds of billions of lines of code in a single day on commodity hardware. In
learning from such an abundance of code, Mentor can learn both good and bad code syntax, interesting and uninteresting
(copied) patterns, semantics, and even recommend patches for defects it finds. Once trained, Mentor’s model can be used for a
variety of tasks such as: (i) detecting potential technical debt or defects and recommending fixes in existing code, (ii) grading
the quality of an existing repository, and (iii) guiding programmers through the important aspects of any code repository, to
name a few.

![System Diagram](https://user-images.githubusercontent.com/92695077/163854383-fadec958-7958-4f27-95be-3f4dcd689f5f.jpg)

At its core, Merly Mentor is a machine programming (MP) system that learns how to identify anomalous code fragments in
source code by training on billions of lines of source code across dozens of programming languages. These anomalous code
fragments, also known as anomalies, are often latent defects in the existing code that programmers have failed to identify or
correct. Mentor helps programmers find these anomalies and correct them, thereby improving the overall quality of the existing
software. For this limited release version of Mentor, we only include Mentor’s ability to perform inference (i.e., detect good
or bad patterns) on code. In subsequent releases, we may also include the ability to train new models on other code bases,
including users’ own proprietary ones.

## Installation Instructions

Below we list Merly Mentor’s installation instructions for the currently supported operating systems (OSes). If you previously
installed Mentor without a product key, but now have one, it is safe to run the MerlyInstaller again to register Mentor with
a product key. A product key is a 16 character string, separated by hyphens each four characters and is generated when you
register Mentor on Merly’s website (e.g., 5SA9-HBP2-WRBV-5WA1). If you encounter any trouble with these steps, please
contact support@merly.ai for assistance.

### Linux (CentOS, RedHat, SUSE, Ubuntu), MacOS (M1 ARM, x64 Intel)

Launch the command line interface (CLI) and execute the following command:

```
  mkdir MPCC
  cd MPCC
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/merly-ai/MPCC-Universal/main/install.sh)"
```
If you have not already registered with your license key, execute the following command from the CLI, where `<key>` is your product key:
```
  ./MerlyInstaller -k <key> install
```

For MacOS, we recommend running Mentor with iTerm2, due to its support of a broader color scheme than is possible for the
default MacOS terminal. You can download it for free here: https://iterm2.com/downloads.html.

### Windows (64-bit)
Launch ```cmd.exe``` (do not use PowerShell as the below cURL command will not work). Navigate to
your user preferred installation directory (e.g., ```cd C:\Users\Paul```). Then execute the following commands where
```<key>``` is your product key:
  
```
  mkdir MPCC
  cd MPCC
  curl -LO https://github.com/merly-ai/MP-CodeCheckBin-Windows/raw/main/bin/latest/MerlyInstaller.exe
  MerlyInstaller -k <key> install
```

### Updating Mentor with the MerlyInstaller
Mentor is constantly being updated. To update your local copy of Mentor to the latest version including updating all of latest
programming language models it supports, simply run the MerlyInstaller (installed in the above installation steps) in the
following way:

```
MerlyInstaller updateall
```

If you would like to update only certain components, please use the ‘usage’ command from the MerlyInstaller as shown below
for more details on how to update only the components you are interested in.

```
MerlyInstaller usage
```

## Interactive Merly Mentor Execution
In this section we describe how to launch Mentor in an interactive fashion. You must first have Mentor installed to perform the
operations in this section. If you haven’t already installed Mentor, please see the [Installation Instructions](#installation-instructions).
To see the steps to launch Mentor in a non-interactive (i.e., logging) mode, please refer to the [Non-Interactive Merly Mentor](#non-interactive-merly-mentor-execution) section. Please refer to the [Merly website](https:\merly.ai) to determine which type of inference your current product license allows.


### <i>Interactive</i> Mentor inference on a file
To run <i>interactive</i> inference on a source file, from the command line interface (CLI), type the following (where [source code file]
is the source code file you want to analyze):

### MacOS, Linux
```
./MerlyMentor infer -D [source code file]
```

### Windows
```
  MerlyMentor.exe infer -D [source code file]
```

### <i>Interactive</i> Mentor inference on a folder
To run <i>interactive</i> inference on a source folder, from the command line interface (CLI), type the following (where [source code folder]
is a directory that contains the folder of code you want to analyze):

### MacOS, Linux
```
./MerlyMentor infer -D [source code folder]
```

### Windows
```
  MerlyMentor.exe infer -D [source code folder]
```

When run successfully, Mentor will display information that looks similar to the screenshot below. This shows the
progress of Mentor extracting the code DNA from the training model. When Mentor has loaded its trained model and processed
the code DNA, it begins inference analysis on all source code that it finds in the files of the directory (or subdirectories) you
have supplied when launching it. 

<img width="769" alt="launch1" src="https://user-images.githubusercontent.com/92695077/169102884-2df8f152-5b54-4546-a194-d3ceb32c12c3.png">

The screenshot below shows an example of Mentor’s inference progress in analyzing a code repository,
how much work it has completed, and how much work is remaining. 

<img width="769" alt="launch2" src="https://user-images.githubusercontent.com/92695077/169102952-dffaab20-4a7c-4c2d-a09b-f4fde0373321.png">

When inference analysis has completed, the Code View screen will appear (shown below), which will allow a user to analyze the inference results as discussed in [Exploring Mentor's Inference Results](#exploring-mentor's-inference-results).

<img width="769" alt="CodeView" src="https://user-images.githubusercontent.com/92695077/169102988-d6b250f8-d681-4167-8f1e-63919cc7c031.png">

## Non-Interactive Merly Mentor Execution
In this section we describe how to launch Mentor in an non-interactive fashion. You must first have Mentor installed to perform the
operations in this section. If you haven’t already installed Mentor, please see the [Installation Instructions](#installation-instructions).
To see the steps to launch Mentor in an interactive (i.e., user interface) mode, please refer to the [Interactive Merly Mentor](#interactive-merly-mentor-execution) section. Please refer to the [Merly website](https:\merly.ai) to determine which type of inference your current product license allows.

A key reason to launch Mentor in non-interactive mode is so that the output Mentor generates can be used as input to
downstream software development or machine learning stages. In this section, we describe how to launch Mentor noninteractively and discuss the number of output files it generates. If you believe an important output is missing from Mentor’s
output file generation, please let us know by email at support@merly.ai.

### <i>Non-interactive</i> Mentor inference on a file
To run <i>non-interactive</i> inference on a source file, from the command line interface (CLI), type the following (where [source code file]
is the source code file you want to analyze):

### MacOS, Linux
```
./MerlyMentor infer -n -D [source code file]
```

### Windows
```
  MerlyMentor.exe infer -n -D [source code file]
```

### <i>Non-interactive</i> Mentor inference on a folder
To run <i>non-interactive</i> inference on a source folder, from the command line interface (CLI), type the following (where [source code folder]
is a directory that contains the folder of code you want to analyze):

### MacOS, Linux
```
./MerlyMentor infer -n -D [source code folder]
```

### Windows
```
  MerlyMentor.exe infer -n -D [source code folder]
```

When Mentor executes successfully in non-interactive mode, it will generate logged anomalous data on the source code files it
performed inference on. The files it generates are the following:

* ```[source code]```.mpcc.anomaly_list.json
* ```[source code]```.mpcc.summary.json
* ```[source code]```.mpcc.original_expressions.json
* ```[source code]``` folder containing each anomalies per file and directory structure.

## Exploring Mentor's Inference Results

After inference analysis is performed, MPCC will show a user interface that includes source code, with an expression highlighted.
We call this screen the *Code View*, which will be described in more detail in Views section of this manual. The image below provides an
example of an anomalous code example found by Mentor.

<img width="1395" alt="anomaly" src="https://user-images.githubusercontent.com/92695077/169103117-e039e3f9-61a7-4c82-a883-ab99abd8eb96.png">


Here's a description of what you'll see on this screen:

**Sort Criteria:** This refers to how Mentor is sorting the list of expressions it has found. This can be via score (a numeric value
assigned by anomaly identification and complexity), or location (sequential code order).

**Class Filter:** This refers to which class of complexity is being filtered in the current view. This can be set from a minimum
value of trivial to a high value of Max complexity.

**Cost Filter:** This refers to a “mental cost” of an expression. This filter can be set from a minimum value of 0 to a maximum
value of 2,000.

**Displayed Items:** This refers to which items Mentor is displaying. It can be set to all expressions, or only anomalous
expressions.

**Hide/Show Known Good:** This refers to whether or not Mentor displays expressions that have been marked by the user as
Known Good.

**Anomaly Identification:** This displays whether or not Mentor has identified the current expression as an anomaly. Non-
anomalous expressions will be classified as “known pattern detected” and highlighted in green. Anomalous expressions will be
classified as “unfamiliar pattern(s) detected” and will be highlighted in purple.

**Cost:** This displays the “mental cost” of the current expression.

**Complexity:** This displays the class of complexity of the current expression.

**Source Code Location:** This displays the file location of the source code under review.

**Anomaly/Expression Count:** This displays the count of the highlighted expression, as well as the total expressions found in
this file. If the user toggles the filter to show only anomalies, this will display the count of highlighted anomaly, and the total
anomalies found in the current file.

**Walking Through Code:** You can move forwards and backwards through the expressions by using the left and right arrow
keys, and can page up and page down through the code (by location) using the Page Up and Page Down keys. You can also
scroll up and down through the code by hold the Control key while pressing the up or the down arrow, respectively.

## Basic Commands and Views

In Mentor, there are a number of supported keyboard and mouse commands. In this section we describe those keystrokes and
explain mouse behavior. Perhaps the most important initial command to remember is the *help* command which can be launched
by pressing the character ’h’ on your keyboard. The help command lists all of the keyboard commands, so if you ever find
yourself not remembering a keyboard command, just press ’h’ and MPCC will launch the keyboard shortcut commands. A
screenshot of the help dialogue box is shown below.

<img width="666" alt="Help" src="https://user-images.githubusercontent.com/92695077/163893676-f5845122-d222-45db-a756-7d8eca1c63a7.png">

In addition to commands, there are several screens (referred to as *views* in this manual) that users can utilize to help them gain deeper insights into specific anomalies, general anomaly information, anomalies by file, anomalies per file, and so forth.

**Code View:** 
The Code View is the default view that Mentor enters when launched. It displays some of the surrounding contextual code for a
given piece of code that Mentor has analyzed and flagged. In the Code View, a user can iterate over all of the segments of
code that Mentor has analyzed using a variety of keyboard and mouse commands (see [Exploring Mentor's Inference Results](#exploring-mentors-inference-results) for more details). The Code View has several utilities, perhaps the most important is to help users understand the surrounding context of code for a given
analyzed code segment to help them determine if an action should (or should not) be taken for that code fragment.

The intuition behind the Code View is that if a code fragment is deemed interesting (or uninteresting) a developer will
likely need to understand the surrounding code context. Code View attempts to provide such surrounding context for the user.
Often times what is shown on the screen may be insufficient context to deeply reason about the code. To help resolve this, a
user can scroll up and down using the keyboard or mouse (more details in [Exploring Mentor's Inference Results](#exploring-mentors-inference-results)).

There are generally two types of labels that Mentor assigns to code it has analyzed: unfamiliar pattern (e.g., potentially
anomalous, which could be a defect or technical debt), or familiar pattern (e.g., code that is unlikely to be the source of technical
debt or a defect). By default Mentor color codes unfamiliar and familiar patterns differently so users can visually discern the
difference. Users can change these colors as discussed in the [Mentor Configuration](#mentor-configuration) section.

<img width="769" alt="CodeView" src="https://user-images.githubusercontent.com/92695077/169103253-67336b12-1317-4722-bf2e-988bf9ac6f6f.png">

**Anomalies View:**
The Anomalies View can be accessed by pressing the ‘a’ key. This view filters out code fragments identified as non-anomalous
by Mentor, and only displays code fragments (across all files) that Mentor identifies as anomalous.

The intuition behind the Anomalies View is that a developer may be interested in looking only at each of the code fragments that Mentor identified as anomalies, instead a full list that includes non-anomalous code fragments. This can allow the developer to focus on code fragments that may need further review for possible updating. Press Enter with an anomaly highlighted to switch back to the Code View of that specific anomaly.

<img width="769" alt="AnomaliesView" src="https://user-images.githubusercontent.com/92695077/169103292-b02129d8-0887-4bc8-a2e2-f072dd90307b.png">

**Notable Expressions View**
The Notable Expressions View can be accessed pressing ‘A’. This view provides a list of code fragments identified as notable
by Merly Mentor.

The intuition behind the Notable Expressions View is that a developer may be interested in code fragments that potentially have a high mental “cost” associated with understanding them. These may be code fragments that are complex and/or harder to read. The developers of Merly Mentor believe that these types of code fragments generally have a tendency to be more “dangerous” in nature, meaning a higher likelihood of being responsible for technical debt and/or the root cause of
future defects if/when this code fragment is called. The developers of Mentor believe that reviewing these code fragments and
simplifying them where possible will lead to better understanding of the code, and potential proactive reduction of future defects.

The Notable Expressions View uses a scoring algorithm that lists the code fragmentsfrom most complex to least complex. The user can scroll through the list in the same fashion as other views, using the up and down arrows, or Page Up and Page Down.

**Files View:**
Depending on the amount of code being reviewed, it may be beneficial to target a specific file or set of files to review. Mentor
has a way to review a specific file called the Files View. Press ‘f’ to switch to the Files View. This view shows all of the source
code files, with the total number of expressions found in each file. You can move up and down the list using the up and down
arrows, or the Page Up and Page Down keys. Press Enter with a file highlighted to switch back to the Code View of the code
fragments within that specific file.

<img width="769" alt="FilesView" src="https://user-images.githubusercontent.com/92695077/169103330-b25af179-4665-47fe-9c90-dbcf5c983b49.png">

**Expressions View:**
If there’s an extensive amount of code to review, it can be easier to review the code by the code fragments Mentor found. The
Expressions View allows the user to do this. Press ‘e’ to switch to the Expressions View. This view shows all of the code
fragments in the current file, sorted by score. Using this view will allow you to see the anomalies in the current file, as they are
listed at the top of the view. You can move up and down the list using the up and down arrows, or the Page Up and Page Down
keys. Also note that you can toggle the sort between code location and score by pressing the ‘s’ key. Press Enter with a code
fragment highlighted to switch back to the Code View with that specific code fragment highlighted.

<img width="675" alt="ExpressionsView" src="https://user-images.githubusercontent.com/92695077/169103358-d4b63f25-0e2e-4eeb-90b1-c39c0eab8cdf.png">

**Details View:**
Once you identify a code fragment that piques your interest, you may want to review it in more detail. You can do this via
the Details view. Press ‘d’ to switch to the Details view. This view shows the detail of the currently selected code fragment
(anomalous or non-anomalous). The detail lets you know how many anomalies Mentor identified within the code fragment,
as well as the cost and the total score. Drilling into these details can provide additional information about the code fragment,
helping to determine if and where the code might need to be updated. Press ‘d’ to return to Code View.

<img width="675" alt="DetailsView" src="https://user-images.githubusercontent.com/92695077/169103404-853c07a1-55bb-486f-952f-027eee1a4df8.png">

**Help Pop-up:**
In addition to the above views, you can press the ‘h’ key in any view to bring up the help screen which will
show you all of the hot keys and their functions.

<img width="666" alt="Help" src="https://user-images.githubusercontent.com/92695077/163893697-a8cd66b9-898b-4f84-8db4-92633864b4a6.png">

## Sorting/Filtering Inference Results

The following lists the ways MPCC’s inference results on source code data can be sorted and/or filtered.

***Sort Criteria:***

**Options:**
* Score (numeric value assigned by anomaly identification and complexity)
* Location (sequential code order)

**Default:** Score

**Toggle:** ‘s’ key

***Class filter***

**Options:**
* Trivial (minimum)
* Basic
* Complex 1
* Complex 2
* Max

**Default:** Trivial

**Adjust:** '1', '2', '3', '4', '5' keys

***Cost filter:***

**Options:**
* 0 (minimum) to 2,000

**Default:** 0

**Adjust:** ',' to decrease, '.' to increase, 'm' to reset to 0 (minimum)

***Hide/Show Known Good:***

**Options:**
* Hide Known Good
* Show Known Good

**Default:** Hide Known Good

**Toggle:** '9' key


## Merly Mentor's Log File Generation
In addition to the live (online) user interface, you can also review the inference results offline through Mentor's logged files. These files are re-generated each time inference is run successfully. These files will be created in the same folder that the Mentor executable was launched and have the following naming structure.

**[Code Repo].by_file.txt:** This file lists all anomalous expressions (that are not nested if’s) found by Mentor. This human
readable file lists the original anomalous source and its normalized version.

**[Code Repo].by_file nested if.txt:** This file lists all nested if expressions that are found by Mentor to be anomalous. This
human readable file lists the original anomalous source and its normalized version.

**[Code Repo].mpcc.anomaly_list.json:** This file lists all expressions that are found by Mentor to be anomalous, in a machine-
readable format.

**[Code Repo].mpcc.summary.json:** This file contains a summary of all of the files, size, and lines of code reviewed by
Mentor. It also provides a summarized report of the number of expressions, anomalies, and scores found in the source code that
inference was performed on, in a machine-readable format.

## Recommendations
In addition to identifying anomalies, Merly Mentor can provide recommended changes to the anomalies it identifies. To use
this feature, select an anomaly (see [Basic Interactive Commands and Views](#basic-interactive-commands-and-views) for more details) and then press ‘r’.
Mentor will then provide a recommendation of a possible change (or changes). This feature is still experimental and results may vary.

In the screenshot below, the highlighted anomaly contains an incorrect double inequality check on the right-hand side of the conditional
expression in the anomalous if statement. In Mentor’s Recommendation (Experimental) list, it contains a partial recommendation
that, if applied, would correct the original, incorrect code.

In the screenshot below, the highlighted anomaly contains an incorrect double equality check in the anomalous if statement that Mentor
has flagged. In Mentor’s Recommendation (Experimental) list, it contains a complete recommendation that, if applied, would
correct the original, incorrect code.

## Advanced Usage
In this section, we describe how to use some of the advanced features of Merly Mentor.

### Command Line Arguments
Merly Mentor has several command line arguments so that you can tailor it to your preferences. Note that you can use the
command line argument usage
```
MerlyMentor usage
```
to review the available command line arguments.

**Version**

Use the command line argument -v to determine the version of Mentor that is currently installed.
For example:
* MacOS, Linux: ```./MerlyMentor -v```
* Windows: ```MerlyMentor.exe -v```

**Help**

Use the command line argument -h to view the list of command line arguments.
For example:
* MacOS, Linux: ```./MerlyMentor -h```
* Windows: ```MerlyMentor.exe -h```

**Quiet**

Use the command line argument -q to run Mentor in no-color mode.
For example:
* MacOS, Linux: ```./MerlyMentor infer -D [source code file] -q```
* Windows: ```MerlyMentor.exe -D [source code file] -q```

For users who wish to customize their MPCC experience, a JSON file is available to configure MPCC to fit your preferences.

The JSON file is located at the following location:

*%appdata%\..\local\merly.ai\debugging\MP-CodeCheck\config.json*

You can use any text editor to modify the colors, log file locations, and settings. Let’s take a closer look.

**Colors:** These are stored in the json file in hexadecimal (HEX) RGB; simply use your favorite color picker to find the
hex value of the color you’d like, and change the value of the associated item.

For example, you can set *anomaly_background* to RGB *ab852e* to change the highlight color of the anomalous expressions to dark orange.

<img width="675" alt="orange_anomalies" src="https://user-images.githubusercontent.com/92695077/169103463-9daf31dd-fb99-4138-a618-355aa8e5dae8.png">

Or, set *highlight_background* to RGB *4a9de0* to change the highlight color of the non-anomalous expressions to light
blue.

<img width="675" alt="blue_expressions" src="https://user-images.githubusercontent.com/92695077/169103507-c6562915-d2e7-4528-9596-47b38e24e772.png">

**Log Files:**

You can change the model path by setting the directory associated with: local-db_root_path

You can change the log path by setting the directory associated with: log_path

**Settings:** 

“run_training” – Determines whether or not training should be run before inference on the source code (defaults to true).

“filter” – Determines if items (such as nested ifs) are extracted from the json anomaly list file (defaults to true).

![banner](https://user-images.githubusercontent.com/92695077/163866689-00f29db2-6176-4e65-bd46-dddf96a6301e.jpg)


