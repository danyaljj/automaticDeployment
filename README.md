# Automatic deployment via SemaphoreCI 

The meat of the project is in `publish.sh` file. 
The current project is based on maven, but it can easily be applied to other projects with minor modifications. 

The requirement is adding two [configuration files](https://semaphoreci.com/docs/adding-custom-configuration-files.html): 
 - ssh private key at `/home/runner/.ssh/KEY_NAME`
 
 - maven username-pass at [`/home/runner/.m2/settings.xml`](https://maven.apache.org/settings.html) 
