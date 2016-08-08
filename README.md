# Automatic deployment via SemaphoreCI 

The meat of the project is in `publish.sh`. 
The current project is based on maven, but it can easily be applied to other projects with minor modifications. 

## Expected behavior 
Here is the expected behavior: 
 - Don't deploy if on a branch other than `master`
 - Don't deploy if on another fork (i.e. pull requests)
 - Don't deploy if the number of parent commits of HEAD is not 2. 
 - otherwise, deploy. 


## Using it 
### Step 1: config files 
You have to add two [configuration files](https://semaphoreci.com/docs/adding-custom-configuration-files.html): 
 - ssh private key at `/home/runner/.ssh/KEY_NAME`
 
 - maven username-pass at [`/home/runner/.m2/settings.xml`](https://maven.apache.org/settings.html) 

### Step 2: `publish.sh`
You have to make some minor changes to the script and move it to your project. 
 - Modify the name of the private key 
 - Change the git commit name/email 