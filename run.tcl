#set working_dir [exec pwd]
#set filename [lindex $argv 0]
#exec chmod +x $filename
#exec ./$filename


#	set shellScriptFilename [lindex $argv 0]

# Execute the shell script using the exec command
#	puts "Running $shellScriptFilename"
#	set scriptFile [open $shellScriptFilename r]
#	set lineNumber 0
#	while {[gets $scriptFile line] != -1} {
#	    incr lineNumber
#	    puts "Executing command $lineNumber"
	    # Execute the command using the exec command
#	    exec sh -c $line
#	    #set result [exec sh $shellScriptFilename]
#	    #puts $result
	#    puts ""
#	}
#	close $scriptFile
#set result [exec sh $shellScriptFilename]
#exec sh $shellScriptFilename
# Display the result of the shell script execution

#puts $result
#
#
#set shellScriptFilename [lindex $argv 0]

# Read the shell script line by line and execute commands
#set scriptFile [open $shellScriptFilename r]
#while {[gets $scriptFile line] != -1} {
#    puts "Info : Executing: $line"
    # Execute the command using the exec command
    #exec sh -c $line
#    set result [exec sh $shellScriptFilename]
#    puts "" ; # Print a new line after each command
#}
#close $scriptFile
#
#
#-------------------------------------------------------------------------------------------
set shellScriptFilename [lindex $argv 0]

 Read the shell script line by line and execute commands
set scriptFile [open $shellScriptFilename r]
set lineNumber 0
while {[gets $scriptFile line] != -1} {
    incr lineNumber
    puts "Executing $lineNumber: $line"
    puts ""
    # Execute the command using the exec command and capture its output
    set result [exec sh -c $line]
    
    # Display the output of the executed command
    puts "Info:Output of $lineNumber:"
    puts $result
    puts ""
    puts ""
    puts ""
}
close $scriptFile

