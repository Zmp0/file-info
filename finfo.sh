#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color (used for green in the content display)

# Function to display information about a file
file_info() {
    echo -e "${CYAN}File Information:${NC}"
    echo -e "${BLUE}-----------------${NC}"
    echo -e "${YELLOW}File Name:${NC} ${GREEN}$(basename "$1")${NC}"
    echo -e "${YELLOW}File Size:${NC} ${GREEN}$(stat --format="%s" "$1") bytes${NC}"
    echo -e "${YELLOW}File Type:${NC} ${GREEN}$(file -b "$1")${NC}"
    echo -e "${YELLOW}File Permissions:${NC} ${GREEN}$(stat --format="%A" "$1")${NC}"
    echo -e "${YELLOW}Last Access Date:${NC} ${GREEN}$(stat --format="%x" "$1")${NC}"
    echo -e "${YELLOW}Last Modification Date:${NC} ${GREEN}$(stat --format="%y" "$1")${NC}"
    echo -e "${YELLOW}Last Status Change Date:${NC} ${GREEN}$(stat --format="%z" "$1")${NC}"
    echo -e "${YELLOW}Owner:${NC} ${GREEN}$(stat --format="%U" "$1")${NC}"
    echo -e "${YELLOW}Group:${NC} ${GREEN}$(stat --format="%G" "$1")${NC}"
    echo -e "${YELLOW}Number of Links:${NC} ${GREEN}$(stat --format="%h" "$1")${NC}"
    echo -e "${YELLOW}Inode Number:${NC} ${GREEN}$(stat --format="%i" "$1")${NC}"
    echo -e "${YELLOW}Executable:${NC} $( [ -x "$1" ] && echo -e "${GREEN}Yes${NC}" || echo -e "${RED}No${NC}" )"
    echo -e "${YELLOW}Readable:${NC} $( [ -r "$1" ] && echo -e "${GREEN}Yes${NC}" || echo -e "${RED}No${NC}" )"
    echo -e "${YELLOW}Writable:${NC} $( [ -w "$1" ] && echo -e "${GREEN}Yes${NC}" || echo -e "${RED}No${NC}" )"

    if [[ $(file --mime-type -b "$1") == text/* ]]; then
        echo -e "${YELLOW}Number of Lines:${NC} ${GREEN}$(wc -l < "$1")${NC}"
        echo -e "${YELLOW}Number of Words:${NC} ${GREEN}$(wc -w < "$1")${NC}"
        echo -e "${YELLOW}Number of Characters:${NC} ${GREEN}$(wc -m < "$1")${NC}"
    else
        echo -e "${YELLOW}This is not a text file, so line/word/character count is not applicable.${NC}"
    fi
}

# Function to display information about a directory
directory_info() {
    echo -e "${CYAN}Directory Information:${NC}"
    echo -e "${BLUE}----------------------${NC}"
    echo -e "${YELLOW}Directory Name:${NC} ${GREEN}$(basename "$1")${NC}"
    echo -e "${YELLOW}Total Number of Files:${NC} ${GREEN}$(find "$1" -type f | wc -l)${NC}"
    echo -e "${YELLOW}Total Number of Subdirectories:${NC} ${GREEN}$(find "$1" -type d | wc -l)${NC}"
    echo -e "${YELLOW}Disk Usage:${NC} ${GREEN}$(du -sh "$1" | cut -f1)${NC}"
    echo -e "${YELLOW}Directory Permissions:${NC} ${GREEN}$(stat --format="%A" "$1")${NC}"
    echo -e "${YELLOW}Last Access Date:${NC} ${GREEN}$(stat --format="%x" "$1")${NC}"
    echo -e "${YELLOW}Last Modification Date:${NC} ${GREEN}$(stat --format="%y" "$1")${NC}"
    echo -e "${YELLOW}Last Status Change Date:${NC} ${GREEN}$(stat --format="%z" "$1")${NC}"
    echo -e "${YELLOW}Owner:${NC} ${GREEN}$(stat --format="%U" "$1")${NC}"
    echo -e "${YELLOW}Group:${NC} ${GREEN}$(stat --format="%G" "$1")${NC}"
    echo -e "${YELLOW}Number of Links:${NC} ${GREEN}$(stat --format="%h" "$1")${NC}"
    echo -e "${YELLOW}Inode Number:${NC} ${GREEN}$(stat --format="%i" "$1")${NC}"
    echo ""
    echo -e "${CYAN}Contents:${NC}"
    echo -e "${BLUE}-------------------------${NC}"
    exa --icons "$1" 
}

# Main script logic

if [ -z "$1" ]; then
    echo -e "${RED}Error: No file or directory provided.${NC}"
    exit 1
fi

if [ ! -e "$1" ]; then
    echo -e "${RED}Error: The specified file or directory does not exist.${NC}"
    exit 1
fi

if [ -f "$1" ]; then
    file_info "$1"
elif [ -d "$1" ]; then
    directory_info "$1"
else
    echo -e "${RED}Error: The specified input is neither a file nor a directory.${NC}"
    exit 1
fi
