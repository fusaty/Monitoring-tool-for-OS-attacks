print("\n  Finishing process...  \n")

# Open the file for reading
with open('output.txt', 'r') as file:
    # Read all the lines in the file into a list
    lines = file.readlines()

# Open the file for writing
with open('output.txt', 'w') as file:
    # Iterate over the lines in the list
    for line in lines:
        # Check if the line is empty (contains only whitespace characters)
        if line.strip():
            # Write the line to the file
            file.write(line)
        
    for line in lines:
        if "Critical" in line:
            # If the string is found, write a message to the console
            print("\n  There is a possibility that your system has been compromised  \n")
        
    