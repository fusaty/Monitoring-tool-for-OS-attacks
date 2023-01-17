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
        if "Possible_shadow_copies_deletion_attack" in line:
            # If the string is found, write a message to the console
            print("\n  There is a possibility of shadow copies deletion attack on your Operating system. \n  Program identified use of vssadmin.exe for shadow copy deletion or resizing on endpoints. \n  This commonly occurs in tandem with ransomware or other destructive attacks.  \n")
        
    