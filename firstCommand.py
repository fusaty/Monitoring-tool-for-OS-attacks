import subprocess

def remove_lines_until(filename, start_line):
    with open(filename, 'r') as f:
        lines = f.readlines()
    with open(filename, 'w') as f:
        for index, line in enumerate(lines):
            if line.startswith(start_line):
                f.write(line)
                position= index+1
                break
        for index, line in enumerate(lines[position:]):
                f.write(line)
                
        
print("\n  Extracting Sysmon logs...  ")

command = 'wevtutil qe Microsoft-Windows-Sysmon/Operational /f:text /q:"*" > sysmonlogs.txt'
subprocess.run(command, shell=True)

remove_lines_until('sysmonlogs.txt', 'Event[16000]:')

# Open the file in read mode
with open('sysmonlogs.txt', 'r') as file:
  # Read in the lines of the file
  lines = file.readlines()
 


## Open the file for writing
with open('sysmonlogs.txt', 'w') as file:
    # Iterate over the lines in the list
    for line in lines:
        # Check if the line starts with "Event"
        if line.startswith("Event"):
            # Split the line into two parts at the first occurrence of "Event"
            parts = line.split("Event", 1)
            # Write the first part of the line to the file
            file.write(parts[0])
            # Write "Event" to the file, followed by a newline character
            file.write("Event\n")
            # Write the second part of the line to the file, without a newline character
            number = (parts[1].strip())
        else:
            # Write the line to the file without adding a newline character
            file.write(number + line)
            number = ""

print("  Sysmon logs were extracted succesfully  \n")