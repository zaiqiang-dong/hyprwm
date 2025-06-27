#!/usr/bin/env bash

add_to_file() {
    local config_file="$1"
    local value="$2"
    if ! sudo grep -q "$value" "$config_file"; then
        echo "Adding $value to $config_file"
        sudo sh -c "echo '$value' >> '$config_file'"
    else
        echo "$value is already present in $config_file."
    fi
}

sudo ubuntu-drivers install
sudo apt update
sudo apt-get install -y libva-wayland2
sudo apt-get install -y libnvidia-egl-wayland1
sudo apt-get install -y nvidia-vaapi-driver

# Additional options to add to GRUB_CMDLINE_LINUX
additional_options="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 rcutree.rcu_idle_gp_delay=1"

# Check if additional options are already present in GRUB_CMDLINE_LINUX
if grep -q "GRUB_CMDLINE_LINUX.*$additional_options" /etc/default/grub; then
    echo "GRUB_CMDLINE_LINUX already contains the additional options"
else
    # Append the additional options to GRUB_CMDLINE_LINUX
    sudo sed -i "s/GRUB_CMDLINE_LINUX=\"/GRUB_CMDLINE_LINUX=\"$additional_options /" /etc/default/grub
    echo "Added the additional options to GRUB_CMDLINE_LINUX"
fi

# Update GRUB configuration
sudo update-grub

# Define the configuration file and the line to add
config_file="/etc/modprobe.d/nvidia.conf"
line_to_add="""
    options nvidia-drm modeset=1 fbdev=1
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    """

# Check if the config file exists
if [ ! -e "$config_file" ]; then
    echo "Creating $config_file"
    sudo touch "$config_file"
fi

add_to_file "$config_file" "$line_to_add"

# Add NVIDIA modules to initramfs configuration
modules_to_add="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
modules_file="/etc/initramfs-tools/modules"

if [ -e "$modules_file" ]; then
    add_to_file "$modules_file" "$modules_to_add"
    sudo update-initramfs -u
else
    echo "Modules file ($modules_file) not found."
fi
