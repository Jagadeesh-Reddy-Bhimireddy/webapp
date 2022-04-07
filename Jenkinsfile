pipeline {
  agent any 	
  tools {
    maven 'Maven'
  }
  	
  stages {
    
    stage ('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            ''' 
      }
    }   
    stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    stage("Building Docker Image"){
	    steps{
		    sh'docker build -t jagadeeshreddybhimireddy/java-web-app-docker .'
	    }
    }
    stage("Docker Hub Login and Push"){
	    steps{
		    withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
			    sh'docker login -u jagadeeshreddybhimireddy -p ${Docker_Hub_Pwd}'
		      }
		    
		    sh'docker push jagadeeshreddybhimireddy/java-web-app-docker'
	    }
	}	    
    stage("Deploying Docker Container with webapp to Prod Server"){
	    steps{
		    sshagent(['Docker_Prod_Server_SSH']) {
                        sh 'ssh -o StrictHostkeyChecking=no ubuntu@172.31.85.1 docker rm -f javawebappcontainer || true'
			    
			sh 'ssh -o StrictHostkeyChecking=no ubuntu@172.31.85.1 docker run -d -p 8080:8080 --name javawebappcontainer jagadeeshreddybhimireddy/java-web-app-docker'
                        }
	          }
	}
  }
}
