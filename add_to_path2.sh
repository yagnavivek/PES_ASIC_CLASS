#!/bin/bash

# Add a directory to the PATH
new_path="/your/directory/path"

# Check if the directory is not already in the PATH
if [[ ":$PATH:" != *":$new_path:"* ]]; then
    echo "Adding $new_path to PATH..."
    echo "export PATH=\$PATH:$new_path" >> ~/.bashrc
    source ~/.bashrc
    echo "Path added successfully."
else
    echo "Directory is already in PATH."
fi

