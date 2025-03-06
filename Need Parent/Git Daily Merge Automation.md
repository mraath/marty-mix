Is there a way to automate the checking out, fetching, pulling latest of two branches? Lets call them DEV and INT. Then create a new branch for DEV. Then merge the latest INT into the latest DEV in this new branch.


> [!ai]+ AI
>
> Yes, this can be achieved through the use of scripting and automation tools. Here's an example script in bash:
> ```
> #!/bin/bash
> # Checkout the DEV branch and fetch the latest changes
> git checkout DEV
> git fetch origin
> git pull
> # Checkout the INT branch and fetch the latest changes
> git checkout INT
> git fetch origin
> git pull
> # Merge the latest INT into the latest DEV in a new branch called "DEV-INT-Merge"
> git checkout -b DEV-INT-Merge DEV
> git merge --no-ff INT
> ```
> This script can be run periodically to ensure that the latest changes from both branches are merged into a new branch. Additionally, this script can be integrated with continuous integration/continuous deployment (CI/CD) tools like Jenkins or Travis CI to automate the process even further.

Save this script to a file, such as "merge.sh", and make it executable using the following command:
chmod +x merge.sh

run it using
./merge.sh




