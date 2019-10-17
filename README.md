# Firmtest-Docker

Build for firmware security test, with binwalk, pwndbg, qemu, and buildroot. Support Postgres SQL with native Postgres instance for non-volatile database for firmadyne.

## Build Command

>docker build -t your_usr_name/your_image_name .

## Run Command

>docker run -d --rm -h IoTvuln --name IoTvuln -v $(pwd):/ctf/work -p 23947:23946 -p 20080:80 -p 20443:433 --cap-add=SYS_PTRACE swordfaith/firmtest-docker:0.1.2