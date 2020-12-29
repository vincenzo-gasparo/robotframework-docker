# robotframework-docker


## Dockerhub
You can find this image on dockerhub @ https://hub.docker.com/r/blastoiseomg/robotframework-docker

## usage
By default the docker image run all tests inside the container /robot folder and outputs test results to /otput folder, so you've got to mount the root test folder (which includes tests and resources) and the output folder.

Example
```
docker run --rm -v $PWD/atests:/robot -v $PWD/output:/output blastoiseomg/robotframework-docker:latest 
```

Inside `run-docker.sh` change:

- **ROBOT_FILES:** path of the folder/file to run inside the root test folder you previously mounted.

- **ROBOT_ARGS:** robot framework command line arguments.

- **ROBOT_ARGS_MASK:** robot framework command line arguments that should not appear in logs for privacy reasons (passwords, apikeys etc.)

- **ROBOT_COMMAND:** either `robot` for single thread execution or `pabot` for parallel execution.


Then:
```
chmod +x run-docker.sh
./run-docker.sh
```
## Dependencies
You can customize python dependencies to be installed by editing `src/requirements.txt` file


## Notes
This docker is able to run both Firefox and Chrome tests.

To let xvfb run, be sure your browser drivers have  `--no-sandbox` and `--disable-gpu` set
