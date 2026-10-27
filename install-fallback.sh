#!/bin/bash
# Install the required dependencies
sudo apt-get install -y python3-pip python3-dev python3-venv
python3 -m venv .venv
./.venv/bin/pip install -r ./requirements.txt

# Enable SPI for the Unicorn HAT Mini
if command -v raspi-config > /dev/null; then
    sudo raspi-config nonint do_spi 0
fi

# Create the service
sed -i "s+/home/pi/unicorn-busy-server+$(pwd)+g" busylight.service
sudo cp busylight.service /etc/systemd/system/busylight.service
sudo systemctl enable busylight.service
sudo systemctl start busylight.service

# Change permissions of the start up script
sudo chmod +x ./start.sh