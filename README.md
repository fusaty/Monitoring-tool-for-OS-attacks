# Monitoring-tool-for-OS-attacks
Our program consists of two Python scripts primarily designed to work with Sysmon logs recorded in a .txt file, a main component written in OCaml, and an executable batch script to run the entire system.
Prerequisites

    Python 3.x
    OCaml 4.0 or higher

## Installation

    Clone the repository to your local machine.
    Install the required dependencies.
    Run the batch script to start the program.

## Usage

The program is designed to work with Sysmon logs recorded in a .txt file. To use the program, follow these steps:

    Place your Sysmon log file in the same directory as the Python scripts.
    Run the batch script to start the program.
    The program will automatically process the Sysmon log file and generate the desired output.

## System Guard - Detecting Potential Attacks on a System

This project consists of two Python scripts designed primarily to work with Sysmon logs saved in a .txt file, a main part written in OCaml, and an executable batch script to run the entire system.

The guard.txt file serves to define events that may represent a potential attack on the system. In this specific case, the file contains four lines, each of which defines one event. Each definition includes an event identification and some attributes that could indicate that an attack is taking place.

In the OCaml code, this file is opened at the beginning and four lines are read into variables firstLine, secondLine, thirdLine, and fourthLine. These variables are later used in the loop cycle, where they are compared with the input events from the system logs. If any of the events match one of the variables, it is evaluated as a potential attack, and the system status is updated accordingly.

For example, the guard.txt file contains a definition of the event "Process Create" with the parameters "Image" and "CommandLine" that correspond to the execution of the command "vssadmin.exe delete shadows /all /quiet". This definition allows us to identify "shadow copies deletion" attacks, where an attacker may remove all shadow copies on the system.

Our OCaml code then scans the Sysmon logs and looks for records that match this definition. If we wanted to define and search for a different attack using this system, we can search for its definition on the MITRE ATT&CK portal, which provides an overview of known attack tactics and techniques used in cyberattacks.
