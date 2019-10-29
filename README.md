# ec2-starter-pack

The package contains the basic files and shell scripts used to prepare a fresh AWS EC2 ubuntu instance as a development server.

**defaults/**: contains docker configurations and files used during laravel projects creation.

### first-run.sh

This file should only be run once, after the instance is created. It is used to update and install all the requirements and to configure various things (swap space, visaul studio code needs, ). **It will reboot the instance at the end of the process, with a 10 second timer.** It will create the **projects** folder, where the next script will add new projects.

### create-laravel-project.sh {project-name}

This file can be used to generate a new laravel project, it will copy default configurations from **defaults/** to the newly created folder.

#How to use

1. Start a fresh EC2/Ubuntu instance from the EC2 console, default parameters should be ok even if i suggest a bigger volume (15Gb)
2. SSH to the instance and clone this repository
3. Run the command:

    `sudo chmod u+x first-run.sh create-laravel-project.sh`
    
4. Run the command:

    `./first-run.sh`
    
    and wait until it reboots the instance.
    
5. Reconnect to the instance and: `cd projects`
6. Create your project: `./create-laravel-project.sh laravel-project`
7. _**Bonus:**_ check if docker is configured correctly:

    `cd laravel-project`
    `docker-compose up -d --build`
    
    Docker should build the images and create the container. You can then edit the instance security group and add *http* as an inboud rule.
    
 
