#!/bin/bash

# Define colors
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Function to check for script updates
check_for_updates() {
    echo -e "${YELLOW}Checking for script updates...${NC}"
    TMP_SCRIPT="/tmp/script-nvidia-smi.sh"
    
    # Download the latest version
    if wget -q https://raw.githubusercontent.com/fat-murphy/script-nvidia-smi/main/script-nvidia-smi.sh -O $TMP_SCRIPT; then
        # Compare with current version
        if ! cmp -s "$0" "$TMP_SCRIPT"; then
            echo -e "${GREEN}New version found! Updating script...${NC}"
            cp "$TMP_SCRIPT" "$0"
            chmod +x "$0"
            echo -e "${GREEN}Script updated successfully! Please run the script again.${NC}"
            rm "$TMP_SCRIPT"
            exit 0
        else
            echo -e "${GREEN}Script is up to date.${NC}"
            rm "$TMP_SCRIPT"
        fi
    else
        echo -e "${RED}Failed to check for updates. Continuing with current version...${NC}"
    fi
}

# Check for updates at startup
check_for_updates

# My sign 
print_sign() {
    echo -e "${GREEN}
    ███████╗ █████╗ ████████╗    ██████╗ ███████╗ ██████╗ 
    ██╔════╝██╔══██╗╚══██╔══╝    ██╔══██╗██╔════╝██╔═══██╗
    █████╗  ███████║   ██║       ██████╔╝█████╗  ██║   ██║
    ██╔══╝  ██╔══██║   ██║       ██╔══██╗██╔══╝  ██║   ██║
    ██║     ██║  ██║   ██║       ██████╔╝███████╗╚██████╔╝
    ╚═╝     ╚═╝  ╚═╝   ╚═╝       ╚═════╝ ╚══════╝ ╚═════╝ 
    ${NC}"
}

# Function to handle reboot
handle_reboot() {
    read -p "Do you want to reboot now? (y/N): " choice
    case "$choice" in
        y|Y)
            echo -e "${YELLOW}System will reboot in 5 seconds...${NC}"
            sleep 5
            sudo reboot
            ;;
        *)
            echo -e "${YELLOW}Please remember to reboot your system to apply changes.${NC}"
            ;;
    esac
}

# Function to install NVIDIA CUDA Toolkit
install_nvidia_cuda_toolkit() {
    echo -e "${YELLOW}Installing NVIDIA CUDA Toolkit...${NC}"
    if sudo apt install nvidia-cuda-toolkit -y; then
        nvcc --version
        
        # Add to .bashrc if not already present
        if ! grep -q "export PATH=/usr/local/cuda/bin" ~/.bashrc; then
            echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
        fi
        
        if ! grep -q "export LD_LIBRARY_PATH=/usr/local/cuda/lib64" ~/.bashrc; then
            echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
        fi
        
        source ~/.bashrc
        echo -e "${GREEN}CUDA Toolkit installation completed successfully.${NC}"
        return 0
    else
        echo -e "${RED}Failed to install CUDA Toolkit.${NC}"
        return 1
    fi
}

# Function to verify installation
verify_installation() {
    echo -e "${YELLOW}Verifying installation...${NC}"
    
    # Check if nvidia-smi command exists and works
    if command -v nvidia-smi &> /dev/null; then
        echo -e "${GREEN}NVIDIA driver is installed. Driver details:${NC}"
        nvidia-smi
        return 0
    else
        echo -e "${RED}NVIDIA driver installation verification failed.${NC}"
        return 1
    fi
}

# Check if the script is running with root privileges
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}This script must be run as root. Please use sudo.${NC}"
    exit 1
else
    print_sign
    echo -e "${YELLOW}Updating package lists and upgrading packages...${NC}"
    if ! (sudo apt update && sudo apt upgrade -y); then
        echo -e "${RED}Failed to update and upgrade packages. Continuing anyway...${NC}"
    fi
    
    echo -e "\n${GREEN}Choose installation type:${NC}"
    echo "1. Install Auto Driver (recommended)"
    echo "2. Install With Driver"
    echo "3. Install CUDA Toolkit"
    read -p "Enter your choice (1-3): " choice
    
    case $choice in
        1)
            echo -e "${YELLOW}Auto installing NVIDIA drivers...${NC}"
            if sudo ubuntu-drivers autoinstall; then
                echo -e "${GREEN}Auto installation completed successfully.${NC}"
                handle_reboot
            else
                echo -e "${RED}Auto installation failed.${NC}"
                exit 1
            fi
            ;;
        2)
            echo -e "${YELLOW}Install specific NVIDIA driver...${NC}"
            read -p "Enter your driver name (example: nvidia-driver-535): " name_driver
            if sudo apt install $name_driver -y; then
                echo -e "${GREEN}Driver installation completed successfully.${NC}"
                verify_installation
                handle_reboot
            else
                echo -e "${RED}Driver installation failed.${NC}"
                exit 1
            fi
            ;;
        3)
            echo -e "${YELLOW}Installing CUDA Toolkit...${NC}"
            if install_nvidia_cuda_toolkit; then
                echo -e "${GREEN}CUDA Toolkit installation completed.${NC}"
            else
                echo -e "${RED}CUDA Toolkit installation failed.${NC}"
                exit 1
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice!${NC}"
            exit 1
            ;;
    esac
fi


